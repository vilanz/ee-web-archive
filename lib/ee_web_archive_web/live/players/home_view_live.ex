defmodule EEWebArchiveWeb.PlayerHomeViewLive do
  alias EEWebArchive.ArchivEE.Players
  use EEWebArchiveWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="flex w-full prose">
      <div class="flex flex-col gap-2 w-full max-w-[600px]">
        <.simple_form for={@form} phx-change="search_player" phx-submit="ignore_submit">
          <h4 class="text-center">Search for a specific player...</h4>
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
      <div class="flex flex-col gap-4 w-full max-w-[250px] px-6">
        <h4 class="text-center">
          ...or check out players with the most plays across their worlds
        </h4>
        <div class="flex flex-col gap-2 mb-4">
          <span :for={{pw, idx} <- Enum.with_index(@most_plays)}>
            #<%= idx + 1 %>: <%= format_number(pw.sum_of_plays) %>
            <.player_link player={pw.player} />
          </span>
        </div>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    form = to_form(%{"name" => ""}, as: "player")
    most_plays = Players.list_by_most_plays()

    {:ok,
     assign(socket,
       form: form,
       player_matches: [],
       exact_player_match: nil,
       most_plays: most_plays
     )}
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
