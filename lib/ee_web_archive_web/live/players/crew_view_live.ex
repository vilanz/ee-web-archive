defmodule EEWebArchiveWeb.CrewViewLive do
  use EEWebArchiveWeb, :live_view

  alias EEWebArchive.ArchivEE.Crews

  def render(assigns) do
    ~H"""
    <div>
      <div>
        Name: <%= @crew.name %>
      </div>
      <h1>Members</h1>
      <.link :for={member <- @crew.members} class="link" navigate={~p"/players/#{member.name}"}>
        <%= member.name %> ::
      </.link>
      <h1>Worlds</h1>
      <.world_mural worlds={@crew.worlds} />
    </div>
    """
  end

  def mount(%{"id" => id}, _session, socket) do
    crew =
      Crews.get_by_id(id)
      |> Crews.preload_members()
      |> Crews.preload_worlds()

    {:ok, assign(socket, crew: crew, page_title: crew.name)}
  end
end
