defmodule EEWebArchiveWeb.PlayerController do
  use EEWebArchiveWeb, :controller

  alias EEWebArchive.ArchivEE.Players

  def get_player(conn, %{"name" => name}) do
    player =
      Players.get_by_name(name)

    if player == nil do
      conn
      |> send_resp(404, "World not found")
    else
      conn
      |> json(player)
    end
  end
end
