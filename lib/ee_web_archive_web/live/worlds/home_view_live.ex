defmodule EEWebArchiveWeb.WorldHomeViewLive do
  alias EEWebArchive.ArchivEE.Worlds

  use EEWebArchiveWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="flex flex-col w-full gap-4">
      <.simple_form for={@form} phx-submit="ignore_submit">
        <h4 class="text-center">Search for worlds...</h4>
        <.input
          field={@form[:query]}
          placeholder="World name"
          phx-change="search_worlds"
          phx-debounce="600"
        />
      </.simple_form>
      <div class="flex flex-wrap justify-around gap-6 mt-4">
        <.world_card :for={world <- @matches} world={world} />
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    form = to_form(%{"query" => ""}, as: "form")

    {:ok,
     assign(socket,
       form: form,
       matches: []
     )}
  end

  def handle_event("search_worlds", %{"form" => %{"query" => query}}, socket) do
    if String.length(query) > 2 do
      matches =
        Worlds.paginate_by_name(query, 1)

      {:noreply, assign(socket, matches: matches)}
    else
      {:noreply, assign(socket, matches: [])}
    end
  end

  def handle_event("ignore_submit", %{}, socket) do
    {:noreply, socket}
  end
end
