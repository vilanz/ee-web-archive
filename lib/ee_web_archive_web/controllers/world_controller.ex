defmodule EEWebArchiveWeb.WorldController do
  use EEWebArchiveWeb, :controller

  alias EEWebArchive.ArchivEE.Worlds

  def download_world(conn, %{"world_id" => world_id}) do
    map_data = Worlds.get_map_data(world_id)

    world = Worlds.get_by_id(world_id)
      |> Worlds.preload_owner_player
    filename = "#{world.name} - #{world.owner_player.name}.eelvl"

    conn
    |> put_resp_header("content-disposition", "attachment; filename=\"#{filename}\"")
    |> send_resp(200, map_data)
  end

  def world_info(conn, %{"world_id" => world_id}) do
    world = Worlds.get_by_id(world_id)

    conn
    |> json(world)
  end
end
