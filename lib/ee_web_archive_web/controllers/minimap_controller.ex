defmodule EEWebArchiveWeb.MinimapController do
  use EEWebArchiveWeb, :controller

  alias EEWebArchive.ArchivEE.WorldParser
  alias EEWebArchive.ArchivEE.Worlds
  alias EEWebArchive.ArchivEE.Minimaps.Minimap

  def archivee_minimap(conn, %{"world_id" => world_id}) do
    minimap_path = Minimap.path(world_id)

    if File.exists?(minimap_path) do
      conn
        |> add_minimap_cache_header()
        |> send_file(200, minimap_path)
    else
      world = Worlds.get_by_id(world_id)

      map_data = Worlds.get_map_data(world_id)
      blocks = WorldParser.parse(map_data)
      minimap_data = Minimap.generate(blocks, world.width, world.height)

      case File.write(minimap_path, minimap_data) do
        :ok ->
          conn
            |> add_minimap_cache_header()
            |> send_file(200, minimap_path)

        {:error, reason} ->
          :logger.error("Failed to save ArchivEE minimap for world #{world_id}: #{reason}")
          conn
            |> send_resp(500, "Failed parsing or writing minimap")
      end
    end
  end

  defp add_minimap_cache_header(conn) do
    put_resp_header(conn, "cache-control", "private, max-age=10080")
  end
end
