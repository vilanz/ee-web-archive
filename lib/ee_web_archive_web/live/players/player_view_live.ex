defmodule EEWebArchiveWeb.PlayerViewLive do
  use EEWebArchiveWeb, :live_view

  alias EEWebArchive.ArchivEE.Players

  def render(assigns) do
    ~H"""
    <div>
      Name: <%= @player.name %>
    </div>
    <div>
      Created: <%= @player.created %>
    </div>
    <div>
      Last login: <%= @player.last_login %>
    </div>
    """
  end

  def mount(%{"name" => name}, _session, socket) do
    player = Players.get_by_name(name)
    IO.inspect(player)
    {:ok, assign(socket, player: player)}
  end
end
