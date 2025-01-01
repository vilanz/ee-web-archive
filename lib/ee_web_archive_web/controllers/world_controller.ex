defmodule EEWebArchiveWeb.WorldController do
  use EEWebArchiveWeb, :controller

  alias EEWebArchive.ArchivEE.Worlds

  def download_world(conn, %{"world_id" => world_id}) do
    world = Worlds.get_by_id(world_id)
      |> Worlds.preload_owner_player

    if world == nil do
      conn
        |> send_resp(404, "World not found")
    else
      filename = "#{world.name} - #{world.owner_player.name}.eelvl"
      map_data = Worlds.get_map_data(world_id)
      conn
        |> put_resp_header("content-disposition", "attachment; filename=\"#{filename}\"")
        |> send_resp(200, map_data)
    end
  end

  def world_info(conn, %{"world_id" => world_id}) do
    world = Worlds.get_by_id(world_id)
      |> Worlds.preload_owner_player
      |> Worlds.add_owner_info_for_json

    if world == nil do
      conn
        |> send_resp(404, "World not found")
    else
      conn
        |> json(world)
    end
  end
end
