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
      <.link
        class="inline-block rounded-lg bg-gray-700 h-26 pl-1 pr-2 no-underline"
        navigate={~p"/players/#{@player.name}"}
      >
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
      <.link
        class="inline-block rounded-lg bg-gray-700 h-26 px-2 h-26 no-underline"
        navigate={~p"/crews/#{@crew.id}"}
      >
        <%= @crew.name %>
      </.link>
    </div>
    """
  end

  attr :world, World

  def world_card(assigns) do
    ~H"""
    <div class="" navigate={~p"/worlds/#{@world.id}"}>
      <h4><%= @world.name %></h4>
      <p><%= @world.plays %> plays</p>
      <img src={"/archivee_minimap/#{@world.rowid}"} />
    </div>
    """
  end

  attr :rest, :global, include: ~w(link)
  attr :class, :string, default: ""
  slot :inner_block

  def menu_link(assigns) do
    ~H"""
    <.link class={"link no-underline hover-blue-500 " <> @class} {@rest}>
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end

  attr :player_id, :integer, default: 1
  attr :scale, :integer, default: 1

  def smiley(assigns) do
    ~H"""
    <img class="smiley" src={"/smileys/#{@player_id}"} style={"transform: scale(#{@scale});"} />
    """
  end

  attr :rest, :global, include: ~w(input)

  def simple_input(assigns) do
    ~H"""
    <input @test />
    """
  end

  attr :size, :integer

  def space(assigns) do
    ~H"""
    <div style={"margin: #{@size * 5}px"} />
    """
  end
end
