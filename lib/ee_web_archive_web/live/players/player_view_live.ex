defmodule EEWebArchiveWeb.PlayerViewLive do
  use EEWebArchiveWeb, :live_view

  alias EEWebArchive.ArchivEE.Players

  def render(assigns) do
    ~H"""
    <div class="flex">
      <div class="basis-[350px] shrink-0">
        <h1>
          <.smiley player_id={@player.id} scale={2} />
          <%= @player.name %>
        </h1>
        <h4>
          Created: <%= @player.created %>
        </h4>
        <h4>
          Last login: <%= @player.last_login %>
        </h4>
        <h2>Crews</h2>
        <div class="flex flex-wrap gap-2">
          <.crew_link :for={crew <- @player.crews} crew={crew} />
        </div>
        <h2>Friends</h2>
        <div class="flex flex-wrap gap-2">
          <.player_link :for={friend <- @player.friends} player={friend} />
        </div>
      </div>
      <div>
        <h1>Worlds</h1>
        <div class="flex flex-wrap justify-around gap-6 mt-4">
          <.world_card :for={world <- @player.worlds} world={world} />
        </div>
      </div>
    </div>
    """
  end

  def mount(%{"name" => name}, _session, socket) do
    player =
      Players.get_by_name(name)
      |> Players.preload_worlds()
      |> Players.preload_friends()
      |> Players.preload_crews()

    {:ok, assign(socket, player: player)}
  end
end
