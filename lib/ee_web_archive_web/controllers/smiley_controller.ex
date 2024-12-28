defmodule EEWebArchiveWeb.SmileyController do
  alias EEWebArchive.Smileys
  use EEWebArchiveWeb, :controller

  def by_player(conn, %{"player_id" => player_id}) do
    smiley_id = Smileys.get_player_smiley_id(player_id)
    path = smiley_path(smiley_id)

    if File.exists?(path) do
      conn
      |> put_resp_header("cache-control", "private, max-age=10080")
      |> send_file(200, path)
    else
      put_status(conn, 404)
    end
  end

  def smiley_path(smiley_id) do
    smiley_filename = "#{smiley_id}.png" # ~p sigil does not allow anything after interpolation
    ~p"/images/smileys/#{smiley_filename}"
  end
end
