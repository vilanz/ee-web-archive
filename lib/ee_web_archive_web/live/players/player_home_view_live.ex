defmodule EEWebArchiveWeb.PlayerHomeViewLive do
  alias EEWebArchive.ArchivEE.Players
  use EEWebArchiveWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="flex flex-col items-center w-full gap-4">
      <div class="flex flex-col gap-2 w-full max-w-[400px] m-20">
        <.simple_form for={@form} phx-submit="ignore_submit">
          <h4 class="text-center">Search for a specific player...</h4>
          <.input
            field={@form[:player_query]}
            placeholder="Player name"
            phx-change="search_player"
            phx-debounce="300"
          />
        </.simple_form>
        <.space size={1} />
        <%= if @exact_player_match do %>
          <div class="flex justify-center">
            <.player_link player={@exact_player_match} />
          </div>
          <.space size={1} />
        <% end %>
        <div class="flex flex-wrap justify-center items-center gap-2 mb-4">
          <.player_link :for={player <- @player_matches} player={player} />
        </div>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    form = to_form(%{"player_query" => ""}, as: "form")

    {:ok,
     assign(socket,
       form: form,
       player_matches: [],
       exact_player_match: nil
     )}
  end

  def handle_event("search_player", %{"form" => %{"player_query" => player_query}}, socket) do
    if String.length(player_query) > 2 do
      player_matches =
        Players.list_by_name(player_query)

      exact_player_match = Enum.find(player_matches, fn player -> player.name == player_query end)

      if exact_player_match do
        player_matches = Enum.filter(player_matches, fn player -> player.name != player_query end)

        {:noreply,
         assign(socket, player_matches: player_matches, exact_player_match: exact_player_match)}
      else
        {:noreply, assign(socket, player_matches: player_matches)}
      end
    else
      {:noreply, assign(socket, player_matches: [], exact_player_match: nil)}
    end
  end

  def handle_event("ignore_submit", %{}, socket) do
    {:noreply, socket}
  end
end
