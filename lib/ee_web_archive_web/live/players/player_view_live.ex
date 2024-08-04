defmodule EEWebArchiveWeb.PlayerViewLive do
  use EEWebArchiveWeb, :live_view

  alias EEWebArchive.ArchivEE.Worlds
  alias EEWebArchive.ArchivEE.Players

  def render(assigns) do
    ~H"""
    <div class="prose">
      <div>
        Name: <%= @player.name %>
      </div>
      <div>
        Created: <%= @player.created %>
      </div>
      <div>
        Last login: <%= @player.last_login %>
      </div>
      <h1>Friends</h1>
      <.link :for={friend <- @player.friends} class="link" navigate={~p"/players/#{friend.name}"}>
        <%= friend.name %>
      </.link>
      <h1>Worlds</h1>
      <.link :for={world <- @player.worlds} class="link" navigate={~p"/worlds/#{world.id}"}>
        <%= world.name %>
      </.link>
      <h1>Crews</h1>
      <.link :for={crew <- @player.crews} class="link" navigate={~p"/crews/#{crew.id}"}>
        <%= crew.name %> <span :if={crew.owner == @player.rowid}>(owner)</span> ::
      </.link>
    </div>
    """
  end

  def mount(%{"name" => name}, _session, socket) do
    player =
      Players.get_by_name(name)
      |> Players.preload_worlds()
      |> Players.preload_friends()
      |> Players.preload_crews()

    Worlds.parse_world_data(Enum.at(player.worlds, 1))

    {:ok, assign(socket, player: player)}
  end
end
