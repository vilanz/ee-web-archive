defmodule EEWebArchiveWeb.PlayerViewLive do
  use EEWebArchiveWeb, :live_view

  alias EEWebArchive.Smileys
  alias EEWebArchive.ArchivEE.Players

  def render(assigns) do
    ~H"""
    <div class="flex gap-2">
      <div class="basis-[350px] shrink-0 flex flex-col gap-2">
        <h1>
          <.smiley player_id={@player.id} scale={2} />
          <%= @player.name %>
        </h1>
        <div>
          <p>
            Joined: <b><%= format_date(@player.created) %></b>
          </p>
          <p>
            Last login: <b><%= format_date(@player.last_login) %></b>
          </p>
        </div>
        <div>
          <h2>Crews: <%= length(@player.crews) %></h2>
          <div class="flex flex-wrap gap-2">
            <.crew_link :for={crew <- @player.crews} crew={crew} />
            <.empty_list data={@player.crews}>
              No crews :(
            </.empty_list>
          </div>
        </div>
        <div>
          <h2>Friends: <%= length(@player.friends) %></h2>
          <div class="flex flex-wrap gap-2">
            <.player_link :for={friend <- @player.friends} player={friend} />
            <.empty_list data={@player.friends}>
              No friends found. :(
            </.empty_list>
          </div>
        </div>
      </div>
      <div>
        <h1>Worlds: <%= length(@player.worlds) %></h1>
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

    smiley_path = Smileys.get_player_smiley_path(player.id)
    full_smiley_path = unverified_url(socket, static_path(socket, smiley_path))
    meta = %{
      title: "Player: #{player.name} (EE Web Archive)",
      image_path: full_smiley_path
    }

    {:ok, assign(socket, player: player, page_title: player.name, meta: meta)}
  end
end
