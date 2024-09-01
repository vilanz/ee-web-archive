defmodule EEWebArchiveWeb.PlayerHomeViewLive do
  alias EEWebArchive.ArchivEE.Players
  use EEWebArchiveWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="flex w-full prose">
      <div class="flex flex-col gap-2 w-full max-w-[600px]">
        <.simple_form for={@form} phx-change="search_player" phx-submit="ignore_submit">
          <h4>Search for a specific player...</h4>
          <.input field={@form[:name]} placeholder="Player name" phx-debounce="300" />
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
    form = to_form(%{"name" => ""}, as: "player")
    {:ok, assign(socket, form: form, player_matches: [], exact_player_match: nil)}
  end

  def handle_event("search_player", %{"player" => %{"name" => name}}, socket) do
    if String.length(name) > 2 do
      player_matches =
        Players.list_by_name(name)

      exact_player_match = Enum.find(player_matches, fn player -> player.name == name end)

      if exact_player_match do
        player_matches = Enum.filter(player_matches, fn player -> player.name != name end)

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
