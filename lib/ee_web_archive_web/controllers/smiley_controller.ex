defmodule EEWebArchiveWeb.SmileyController do
  alias EEWebArchive.Smileys
  use EEWebArchiveWeb, :controller

  def by_player(conn, %{"player_id" => player_id}) do
    smiley_id = Smileys.get_player_smiley_id(player_id)

    path = "./priv/static/images/smileys/#{smiley_id}.png"

    if File.exists?(path) do
      conn
      |> put_resp_header("cache-control", "private, max-age=10080")
      |> send_file(200, path)
    else
      put_status(conn, 404)
    end
  end
end
