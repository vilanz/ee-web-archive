defmodule EEWebArchiveWeb.WorldController do
  use EEWebArchiveWeb, :controller

  alias EEWebArchive.ArchivEE.Worlds

  def download_world(conn, %{"world_rowid" => world_rowid}) do
    map_data = Worlds.get_map_data(world_rowid)

    conn
    |> send_resp(200, map_data)
  end

  def world_info(conn, %{"world_rowid" => world_rowid}) do
    world = Worlds.get_by_rowid(world_rowid)

    conn
    |> json(world)
  end
end
