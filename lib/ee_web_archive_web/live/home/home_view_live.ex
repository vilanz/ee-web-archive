defmodule EEWebArchiveWeb.HomeViewLive do
  alias EEWebArchive.ArchivEE.Worlds
  use EEWebArchiveWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="flex flex-col h-full">
      <h3>Welcome to the EE Web Archive v2 beta!</h3>
      <div>
        <div class="flex items-center gap-4">
          <b>Here, have some assorted worlds...</b>
          <.button class="btn-sm btn-secondary" phx-click="refresh_worlds">More worlds!</.button>
        </div>
        <.world_mural worlds={@featured_worlds} />
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    featured_worlds = Worlds.list_frequently_played_at_random()

    {:ok,
     assign(socket,
       featured_worlds: featured_worlds
     )}
  end

  def handle_event("refresh_worlds", _value, socket) do
    featured_worlds = Worlds.list_frequently_played_at_random()
    {:noreply, assign(socket, :featured_worlds, featured_worlds)}
  end
end
