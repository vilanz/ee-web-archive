defmodule EEWebArchiveWeb.SmileyController do
  alias EEWebArchive.Smileys
  use EEWebArchiveWeb, :controller

  def by_player(conn, %{"player_id" => player_id}) do
    smiley_path = Smileys.get_player_smiley_path(player_id)
    conn
      |> redirect(to: smiley_path)
  end
end
