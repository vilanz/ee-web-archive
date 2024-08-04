defmodule EEWebArchive.ArchivEE.Worlds do
  alias EEWebArchive.ArchivEERepo
  alias EEWebArchive.ArchivEE.World
  alias EEWebArchive.ArchivEE.WorldData
  alias EEWebArchive.ArchivEE.WorldDataParser

  def get_by_id(id) do
    ArchivEERepo.get_by(World, id: id)
  end

  def preload_owning_player(world) do
    ArchivEERepo.preload(world, :owning_player)
  end

  def preload_owning_crew(world) do
    ArchivEERepo.preload(world, :owning_crew)
  end

  def parse_world_data(%World{:data_entity => %WorldData{:data => data}}) do
    WorldDataParser.parse_world_data(data)
  end

  def parse_world_data(_invalid_world_data) do
    "lol invalid world"
  end
end
