defmodule EEWebArchiveWeb.SmileyController do
  alias EEWebArchive.Smileys
  use EEWebArchiveWeb, :controller

  def by_player(conn, %{"player_id" => player_id}) do
    smiley_id = Smileys.get_player_smiley_id(player_id)
    conn
      |> put_resp_header("cache-control", "private, max-age=10080")
      |> redirect(to: smiley_path(conn, smiley_id))
  end

  def smiley_path(conn, smiley_id) do
    static_path(conn, "/images/smileys/#{smiley_id}.png")
  end
end
