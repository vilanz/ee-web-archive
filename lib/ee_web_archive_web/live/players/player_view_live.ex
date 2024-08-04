defmodule EEWebArchiveWeb.PlayerViewLive do
  alias EEWebArchive.ArchivEE.Worlds
  use EEWebArchiveWeb, :live_view

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
      <%= for friend <- @player.friends do %>
        <a class="link" href={~p"/players/#{friend.name}"}>
          <%= friend.name %>
        </a>
        ::
      <% end %>
      <h1>Worlds</h1>
      <%= for world <- @player.worlds do %>
        <span>
          <%= world.name %> ::
        </span>
      <% end %>
    </div>
    """
  end

  def mount(%{"name" => name}, _session, socket) do
    player =
      Players.get_by_name(name)
      |> Players.preload_worlds()
      |> Players.preload_friends()

    Worlds.parse_world_data(Enum.at(player.worlds, 1))

    {:ok, assign(socket, player: player)}
  end
end
