defmodule EEWebArchive.ArchivEE.Worlds do
  alias EEWebArchive.ArchivEE.WorldDataParser

  def parse_world_data(world) do
    WorldDataParser.parse_world_data(world.data.data)
    |> IO.inspect()
  end
end
