defmodule EEWebArchive.ArchivEE.Worlds do
  import Ecto.Query

  alias EEWebArchive.ArchivEERepo
  alias EEWebArchive.ArchivEE.World

  @spec get_by_id(integer()) :: World.t()
  def get_by_id(id) do
    ArchivEERepo.get_by(World, id: id)
  end

  def preload_owner_player(world) do
    ArchivEERepo.preload(world, :owner_player)
  end

  def preload_owner_crew(world) do
    ArchivEERepo.preload(world, :owner_crew)
  end

  def add_owner_info_for_json(%{owner_player: %{rowid: rowid, id: id, name: name}} = world) do
    Map.put(world, :owner, %{rowid: rowid, id: id, username: name})
  end

  # If there's no owner_player info (e.g. world not found)
  def add_owner_info_for_json(world) do
    world
  end

  @spec get_map_data(integer()) :: bitstring()
  def get_map_data(world_id) do
    %{rows: [[data]]} =
      ArchivEERepo.query!(
        """
          SELECT zstd_decompress(d.data, false, 1, true)
          FROM world w
          JOIN _world_data_zstd d ON w.data_ref = d.rowid
          WHERE w.id == ?
        """,
        [world_id]
      )

    data
  end

  def list_frequently_played_at_random() do
    random_worlds_query =
      from w in World,
        order_by: fragment("RANDOM()"),
        where: w.plays > 10000,
        limit: 20

    query =
      from rw in subquery(random_worlds_query),
        order_by: [desc: rw.plays]

    ArchivEERepo.all(query)
  end

  def paginate_by_name(name, page) do
    items_per_page = 10
    offset = items_per_page * (page - 1)

    query =
      from w in World,
        order_by: [desc: :plays],
        where: like(w.name, ^"%#{name}%"),
        limit: ^items_per_page,
        offset: ^offset

    ArchivEERepo.all(query)
  end
end
