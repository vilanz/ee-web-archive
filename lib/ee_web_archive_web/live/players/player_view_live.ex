defmodule EEWebArchiveWeb.PlayerViewLive do
  alias EEWebArchive.ArchivEE.WorldDataParser
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

    WorldDataParser.add(1, 2)
    |> IO.inspect()

    {:ok, assign(socket, player: player)}
  end
end
