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
      <.link class="link" navigate={~p"/players/#{@player.name}"}>
        <%= @player.name %>
      </.link>
    </div>
    """
  end

  attr :crew, Crew

  def crew_link(assigns) do
    ~H"""
    <div class="">
      <.link class="link" navigate={~p"/crews/#{@crew.id}"}>
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

  def menu_link(assigns) do
    ~H"""
    <.link class={"link no-underline hover-blue-500 " <> @class} {@rest}>
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end
end
