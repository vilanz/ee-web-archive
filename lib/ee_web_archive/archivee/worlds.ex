defmodule EEWebArchive.ArchivEE.Worlds do
  import Ecto.Query

  alias EEWebArchive.ArchivEERepo
  alias EEWebArchive.ArchivEE.World

  @spec get_by_id(integer()) :: World.t() | nil
  def get_by_id(id) do
    query =
      from w in World,
        where: w.id == ^id,
        preload: [:owner_player, :owner_crew],
        select: w

    ArchivEERepo.one(query)
  end

  def get_by_owner_name(name) do
    query =
      from w in World,
        join: p in assoc(w, :owner_player),
        where: p.name == ^name,
        preload: [:owner_crew],
        select: w

    ArchivEERepo.all(query)
  end

  def preload_owner_crew(world) do
    ArchivEERepo.preload(world, :owner_crew)
  end

  def add_owner_to_json(world) do
    with %{owner_player: %{rowid: rowid, id: id, name: name}} <- world do
      Map.put(world, :owner, %{rowid: rowid, id: id, username: name})
    else
      _ -> world
    end
  end

  def add_crew_to_json(world) do
    with %{owner_crew: %{rowid: rowid, id: id, name: name}} <- world do
      Map.put(world, :crew, %{rowid: rowid, id: id, name: name})
    else
      _ -> world
    end
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

  # TODO: Enforce minimum_plays and limit params, refactor the LiveView using this
  def list_frequently_played_at_random(minimum_plays \\ 10000, limit \\ 10) do
    random_worlds_query =
      from w in World,
        order_by: fragment("RANDOM()"),
        where: w.plays >= ^minimum_plays,
        limit: ^limit

    query =
      from rw in subquery(random_worlds_query),
        preload: [:owner_player, :owner_crew],
        order_by: [desc: rw.plays]

    ArchivEERepo.all(query)
  end

  def paginate_by_name(name, page) do
    items_per_page = 10
    offset = items_per_page * (page - 1)

    query =
      from w in World,
        order_by: [desc: :plays],
        preload: [:owner_player, :owner_crew],
        where: like(w.name, ^"%#{name}%"),
        limit: ^items_per_page,
        offset: ^offset

    ArchivEERepo.all(query)
  end
end
