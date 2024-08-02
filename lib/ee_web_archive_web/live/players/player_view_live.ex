defmodule EEWebArchiveWeb.PlayerViewLive do
  alias EEWebArchive.ArchivEE.Worlds
  alias EEWebArchive.ArchivEERepo
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
    <%= for world <- @player.worlds do %>
      <span>
        <%= world.name %> ::
      </span>
    <% end %>
    """
  end

  def mount(%{"name" => name}, _session, socket) do
    player =
      Players.get_by_name(name)
      |> ArchivEERepo.preload(worlds: [:data])

    Worlds.parse_world_data(Enum.at(player.worlds, 1))

    {:ok, assign(socket, player: player)}
  end
end
