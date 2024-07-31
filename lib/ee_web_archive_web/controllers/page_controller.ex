defmodule EEWebArchiveWeb.PageController do
  use EEWebArchiveWeb, :controller

  def home(conn, _params) do
    player = get_player()
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false, player: player)
  end

  def get_player() do
    ArchivEE.Player
      |> EEWebArchive.ArchivEERepo.get_by(name: "0176")
  end
end
