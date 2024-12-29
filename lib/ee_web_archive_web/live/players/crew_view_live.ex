defmodule EEWebArchiveWeb.CrewViewLive do
  use EEWebArchiveWeb, :live_view

  alias EEWebArchive.ArchivEE.Crews

  def render(assigns) do
    ~H"""
    <div class="flex flex-col gap-4">
      <h1>
        <%= @crew.name %>
      </h1>
      <div>
        <h3>Members: <%= length(@crew.members) %></h3>
        <div class="flex flex-wrap gap-2">
          <.player_link :for={member <- @crew.members} player={member} highlight={member.rowid == @crew.owner} />
          <.empty_list data={@crew.members}>
            No players...? What??
          </.empty_list>
        </div>
      </div>
      <div>
        <h3>Worlds: <%= length(@crew.worlds) %></h3>
        <.world_mural worlds={@crew.worlds} />
      </div>
    </div>
    """
  end

  def mount(%{"id" => id}, _session, socket) do
    crew =
      Crews.get_by_id(id)
      |> Crews.preload_members()
      |> Crews.preload_worlds()
      |> Crews.place_owner_first()

    {:ok, assign(socket, crew: crew, page_title: crew.name)}
  end
end
