defmodule EEWebArchiveWeb.PlayerViewLive do
  use EEWebArchiveWeb, :live_view

  alias EEWebArchive.ArchivEE.Players

  def render(assigns) do
    ~H"""
    <div class="flex gap-2">
      <div class="basis-[350px] shrink-0">
        <h1>
          <.smiley player_id={@player.id} scale={2} />
          <%= @player.name %>
        </h1>
        <p>
          <b>
            Created at
          </b>
          <%= format_date(@player.created) %>
        </p>
        <p>
          <b>
            Last login at
          </b>
          <%= format_date(@player.last_login) %>
        </p>
        <h2>Crews</h2>
        <div class="flex flex-wrap gap-2">
          <.crew_link :for={crew <- @player.crews} crew={crew} />
          <.empty_list data={@player.crews}>
            No crews found.
          </.empty_list>
        </div>
        <h2>Friends</h2>
        <div class="flex flex-wrap gap-2">
          <.player_link :for={friend <- @player.friends} player={friend} />
          <.empty_list data={@player.friends}>
            No friends found. :(
          </.empty_list>
        </div>
      </div>
      <div>
        <h1>Worlds</h1>
        <.empty_list data={@player.worlds}>
          No worlds found.
        </.empty_list>
        <.world_mural worlds={@player.worlds} />
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
