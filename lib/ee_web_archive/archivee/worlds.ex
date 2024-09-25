defmodule EEWebArchive.ArchivEE.Worlds do
  import Ecto.Query

  alias EEWebArchive.ArchivEERepo
  alias EEWebArchive.ArchivEE.World

  @spec get_by_rowid(integer()) :: World.t()
  def get_by_rowid(rowid) do
    ArchivEERepo.get_by(World, rowid: rowid)
  end

  def preload_owning_player(world) do
    ArchivEERepo.preload(world, :owning_player)
  end

  def preload_owning_crew(world) do
    ArchivEERepo.preload(world, :owning_crew)
  end

  @spec get_map_data(integer()) :: bitstring()
  def get_map_data(world_rowid) do
    %{rows: [[data]]} =
      ArchivEERepo.query!(
        """
          SELECT zstd_decompress(d.data, false, 1, true)
          FROM world w
          JOIN _world_data_zstd d ON w.data_ref = d.rowid
          WHERE w.rowid == ?
        """,
        [world_rowid]
      )

    data
  end

  def list_most_played() do
    query =
      from w in World,
        order_by: [desc: :plays],
        limit: 10

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
