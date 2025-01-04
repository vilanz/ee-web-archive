defmodule EEWebArchiveWeb.Components do
  use Phoenix.Component

  use Phoenix.VerifiedRoutes,
    endpoint: EEWebArchiveWeb.Endpoint,
    router: EEWebArchiveWeb.Router,
    statics: EEWebArchiveWeb.static_paths()

  alias EEWebArchive.ArchivEE.Crew
  alias EEWebArchive.ArchivEE.World
  alias EEWebArchive.ArchivEE.Player

  attr :player, Player, required: true
  attr :highlight, :boolean, default: false

  def player_link(assigns) do
    ~H"""
    <div class="">
      <.link class={["chip shadow-sm", @highlight && "chip-highlight"]} navigate={~p"/players/#{@player.name}"}>
        <.smiley player_id={@player.id} />
        <%= @player.name %>
      </.link>
    </div>
    """
  end

  attr :crew, Crew, required: true

  def crew_link(assigns) do
    ~H"""
    <div class="">
      <.link class="chip px-1 shadow-sm" navigate={~p"/crews/#{@crew.id}"}>
        <%= @crew.name %>
      </.link>
    </div>
    """
  end

  attr :world, World, required: true
  attr :show_owner, :boolean, default: false

  def world_card(assigns) do
    ~H"""
    <div class="min-h-0 bg-neutral-950 rounded-lg card card-compact shadow-lg text-md">
      <figure class="bg-black p-4">
        <img class="shadow-lg bg-black" src={"/archivee_minimap/#{@world.id}"} height={@world.height} width={@world.width} loading="lazy"  />
      </figure>
      <div class="card-body !p-4 gap-3">
        <h4><%= @world.name %></h4>
        <div>Plays: <b><%= @world.plays %></b></div>
        <%= if @show_owner do %>
          <div class="flex items-center gap-2">
            By
            <%= cond do %>
              <% @world.owner_player != nil -> %>
                <.player_link player={@world.owner_player} />
              <% @world.owner_crew != nil -> %>
                <.crew_link crew={@world.owner_crew} />
              <% true -> %> <span>No owner found</span>
            <% end %>
          </div>
        <% end %>
        <div class="flex gap-3">
          <a type="button" class="btn btn-xs btn-primary" href={"https://pixelwalker.net/world/legacy:#{@world.id}"} target="_blank">
            Play
          </a>
          <a type="button" class="btn btn-xs" href={"/api/worlds/download/#{@world.id}"} download>
            Download
          </a>
        </div>
      </div>
    </div>
    """
  end

  attr :worlds, :list, required: true
  attr :show_owner, :boolean, default: false

  def world_mural(assigns) do
    ~H"""
    <div class="flex flex-wrap justify-around items-center gap-2 gap-y-10 mt-2">
      <.world_card :for={world <- @worlds} world={world} show_owner={@show_owner} />
    </div>
    """
  end

  attr :to, :string
  attr :external_href, :string
  attr :rest, :global
  attr :class, :string, default: ""
  slot :inner_block

  def menu_link(assigns) do
    ~H"""
    <li>
      <.link class={"link no-underline bg-neutral-900 " <> @class} navigate={@to} {@rest}>
        <%= render_slot(@inner_block) %>
      </.link>
    </li>
    """
  end

  attr :href, :string
  attr :rest, :global
  attr :class, :string, default: ""
  slot :inner_block

  def external_menu_link(assigns) do
    ~H"""
    <li>
      <.link class={"link no-underline bg-neutral-900 " <> @class} href={@href} target="_blank" {@rest}>
        <%= render_slot(@inner_block) %>
      </.link>
    </li>
    """
  end

  attr :player_id, :integer, default: 1
  attr :scale, :integer, default: 1

  def smiley(assigns) do
    ~H"""
    <img class="smiley" src={"/smileys/#{@player_id}"} style={"transform: scale(#{@scale});"} />
    """
  end

  attr :size, :integer

  def space(assigns) do
    ~H"""
    <div style={"margin: #{@size * 5}px"} />
    """
  end

  slot :header, required: true
  slot :items, required: true

  def submenu(assigns) do
    ~H"""
    <li>
      <span class="!bg-inherit !cursor-default">
        <%= render_slot(@header) %>
      </span>
      <ul>
        <%= render_slot(@items) %>
      </ul>
    </li>
    """
  end

  attr :data, :list
  slot :inner_block

  def empty_list(assigns) do
    ~H"""
    <%= if Enum.empty?(@data) or @data == nil do %>
      <%= render_slot(@inner_block) %>
    <% end %>
    """
  end
end
