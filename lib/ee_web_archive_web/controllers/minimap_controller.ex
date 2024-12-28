defmodule EEWebArchiveWeb.MinimapController do
  use EEWebArchiveWeb, :controller

  alias EEWebArchive.ArchivEE.WorldParser
  alias EEWebArchive.ArchivEE.Worlds
  alias EEWebArchive.ArchivEE.Minimaps.Minimap

  def archivee_minimap(conn, %{"world_id" => world_id}) do
    minimap_path = Minimap.path(world_id)

    if File.exists?(minimap_path) do
      send_file(conn, 200, minimap_path)
    else
      world = Worlds.get_by_id(world_id)

      map_data = Worlds.get_map_data(world_id)
      blocks = WorldParser.parse(map_data)
      minimap_data = Minimap.generate(blocks, world.width, world.height)

      case File.write(minimap_path, minimap_data) do
        :ok ->
          send_file(conn, 200, minimap_path)

        {:error, reason} ->
          :logger.error("Failed to save ArchivEE minimap for world #{world_id}: #{reason}")
          put_status(conn, 500)
      end
    end
  end
end
