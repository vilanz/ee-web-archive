defmodule EEWebArchive.ArchivEE.Worlds do
  alias EEWebArchive.ArchivEE.WorldDataParser
  alias EEWebArchive.ArchivEE.World
  alias EEWebArchive.ArchivEE.WorldData

  def parse_world_data(%World{:data_entity => %WorldData{:data => data}}) do
    WorldDataParser.parse_world_data(data)
  end

  def parse_world_data(_invalid_world_data) do
    "lol invalid world"
  end
end
