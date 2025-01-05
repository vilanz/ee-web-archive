defmodule EEWebArchiveWeb.HomeViewLive do
  use EEWebArchiveWeb, :live_view

  alias EEWebArchive.ArchivEE.Worlds

  def render(assigns) do
    ~H"""
    <div class="flex flex-col">
      <h3>Welcome to the EE Web Archive v2 beta!</h3>
      <div>
        <div class="flex items-center gap-4">
          <b>Here, have some assorted worlds...</b>
          <.button class="btn-sm btn-secondary" phx-click="refresh_worlds">More worlds!</.button>
        </div>
        <.world_mural worlds={@featured_worlds} show_owner />
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    featured_worlds =
      Worlds.list_frequently_played_at_random()
      |> Worlds.preload_owner_player()
      |> Worlds.preload_owner_crew()

    {:ok,
     assign(socket,
       featured_worlds: featured_worlds,
       page_title: "Home"
     )}
  end

  def handle_event("refresh_worlds", _value, socket) do
    featured_worlds =
      Worlds.list_frequently_played_at_random()
      |> Worlds.preload_owner_player()
      |> Worlds.preload_owner_crew()

    {:noreply, assign(socket, :featured_worlds, featured_worlds)}
  end
end
