defmodule EEWebArchive.ArchivEE.Worlds do
  alias EEWebArchive.ArchivEERepo
  alias EEWebArchive.ArchivEE.World

  def get_by_id(id) do
    ArchivEERepo.get_by(World, id: id)
  end

  def preload_owning_player(world) do
    ArchivEERepo.preload(world, :owning_player)
  end

  def preload_owning_crew(world) do
    ArchivEERepo.preload(world, :owning_crew)
  end

  def parse_worlds_data(worlds) do
    world_rowids = Enum.map(worlds, fn world -> world.rowid end)

    sql_world_rowids_in = Enum.join(Enum.map(world_rowids, fn _ -> "?" end), ",")

    %{rows: rows} =
      ArchivEERepo.query!(
        """
          SELECT zstd_decompress(d.data, false, 1, true)
          FROM world w
          JOIN _world_data_zstd d ON w.data_ref = d.rowid
          WHERE w.rowid IN (#{sql_world_rowids_in})
        """,
        world_rowids
      )

    Enum.each(List.flatten(rows), fn data -> byte_size(data) |> IO.inspect() end)
  end

  def parse_world_data(_invalid_world_data) do
    "lol invalid world"
  end
end
