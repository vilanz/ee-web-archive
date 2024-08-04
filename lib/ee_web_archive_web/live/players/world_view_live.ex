defmodule EEWebArchiveWeb.WorldViewLive do
  use EEWebArchiveWeb, :live_view

  alias EEWebArchive.ArchivEE.Worlds

  def render(assigns) do
    ~H"""
    <div class="prose">
      <div>
        Name: <%= @world.name %>
      </div>
      <div>
        Owner player: <%= get_in(@world, [Access.key(:owning_player), Access.key(:name)]) %>
      </div>
      <div>
        Owner crew: <%= get_in(@world, [Access.key(:owning_crew), Access.key(:name)]) %>
      </div>
    </div>
    """
  end

  def mount(%{"id" => id}, _session, socket) do
    world =
      Worlds.get_by_id(id)
      |> Worlds.preload_owning_player()
      |> Worlds.preload_owning_crew()

    {:ok, assign(socket, world: world)}
  end
end
