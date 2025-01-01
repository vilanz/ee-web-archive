defmodule EEWebArchiveWeb.SmileyController do
  alias EEWebArchive.Smileys
  use EEWebArchiveWeb, :controller

  def by_player(conn, %{"player_id" => player_id}) do
    smiley_path = Smileys.get_player_smiley_path(player_id)
    conn
      |> put_resp_header("cache-control", "private, max-age=10080")
      |> redirect(to: smiley_path)
  end
end
