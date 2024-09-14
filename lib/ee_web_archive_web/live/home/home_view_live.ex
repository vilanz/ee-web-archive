defmodule EEWebArchiveWeb.HomeViewLive do
  alias EEWebArchive.ArchivEE.Worlds
  use EEWebArchiveWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="flex flex-col items-center h-full">
      <h4>Welcome to the EE Web Archive!</h4>
      <div>
        <h2>Worlds</h2>
        <div class="flex flex-wrap justify-around gap-6 mt-4">
          <.world_card :for={world <- @featured_worlds} world={world} />
        </div>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    featured_worlds = Worlds.list_most_played()

    {:ok,
     assign(socket,
       featured_worlds: featured_worlds
     )}
  end
end
