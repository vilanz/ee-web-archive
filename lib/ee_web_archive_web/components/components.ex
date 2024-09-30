defmodule EEWebArchiveWeb.Components do
  use Phoenix.Component

  use Phoenix.VerifiedRoutes,
    endpoint: EEWebArchiveWeb.Endpoint,
    router: EEWebArchiveWeb.Router,
    statics: EEWebArchiveWeb.static_paths()

  alias EEWebArchive.ArchivEE.Crew
  alias EEWebArchive.ArchivEE.World
  alias EEWebArchive.ArchivEE.Player

  attr :player, Player

  def player_link(assigns) do
    ~H"""
    <div class="">
      <.link class="chip" navigate={~p"/players/#{@player.name}"}>
        <.smiley player_id={@player.id} />
        <%= @player.name %>
      </.link>
    </div>
    """
  end

  attr :crew, Crew

  def crew_link(assigns) do
    ~H"""
    <div class="">
      <.link class="chip" navigate={~p"/crews/#{@crew.id}"}>
        <%= @crew.name %>
      </.link>
    </div>
    """
  end

  attr :world, World

  def world_card(assigns) do
    ~H"""
    <div class="min-h-0">
      <h4><%= @world.name %></h4>
      <p><%= @world.plays %> plays</p>
      <img src={"/archivee_minimap/#{@world.rowid}"} />
    </div>
    """
  end

  attr :rest, :global
  attr :class, :string, default: ""
  attr :navigate, :string
  slot :inner_block

  def menu_link(assigns) do
    ~H"""
    <li>
      <.link class={"link no-underline hover-blue-500 " <> @class} {@rest}>
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
end
