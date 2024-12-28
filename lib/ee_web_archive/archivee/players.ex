defmodule EEWebArchive.ArchivEE.Players do
  import Ecto.Query

  alias EEWebArchive.ArchivEE
  alias EEWebArchive.ArchivEERepo
  alias EEWebArchive.ArchivEE.Player
  alias EEWebArchive.ArchivEE.World
  alias EEWebArchive.ArchivEE.Crew

  @spec get_by_name(String.t()) :: %Player{}
  def get_by_name(name) do
    ArchivEERepo.get_by(Player, name: name)
  end

  @spec list_by_name(String.t()) :: list(%Player{})
  def list_by_name(name) do
    ArchivEERepo.all(from player in Player, where: like(player.name, ^"%#{name}%"))
  end

  @spec preload_worlds(%Player{}) :: %Player{worlds: list(%World{})}
  def preload_worlds(player) do
    worlds_ordered_by_plays = from(w in ArchivEE.World, order_by: [desc: w.plays])
    ArchivEERepo.preload(player, worlds: {worlds_ordered_by_plays, [:data_entity]})
  end

  @spec preload_friends(%Player{}) ::
          %Player{friends: list(%Player{})}
  def preload_friends(player) do
    ArchivEERepo.preload(player, :friends)
  end

  @spec preload_crews(%Player{}) :: %Player{crews: %Crew{}}
  def preload_crews(player) do
    ArchivEERepo.preload(player, :crews)
  end

  # def list_by_most_plays() do
  #   query =
  #     from p in Player,
  #       inner_join: w in assoc(p, :worlds),
  #       select: %{
  #         player: p,
  #         sum_of_plays: selected_as(sum(w.plays), :sum_of_plays)
  #       },
  #       group_by: [p.id],
  #       order_by: [desc: selected_as(:sum_of_plays)],
  #       limit: 20

  #   ArchivEERepo.all(query)
  # end
end
