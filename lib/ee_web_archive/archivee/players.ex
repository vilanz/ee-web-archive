defmodule EEWebArchive.ArchivEE.Players do
  alias EEWebArchive.Smileys
  alias EEWebArchive.ArchivEERepo
  alias EEWebArchive.ArchivEE.Player
  alias EEWebArchive.ArchivEE.World
  alias EEWebArchive.ArchivEE.Crew

  @spec get_by_name(String.t()) :: %Player{}
  def get_by_name(name) do
    ArchivEERepo.get_by(Player, name: name)
  end

  @spec preload_worlds(%Player{}) :: %Player{worlds: list(%World{})}
  def preload_worlds(player) do
    ArchivEERepo.preload(player, worlds: [:data_entity])
  end

  @spec preload_worlds(%Player{}) ::
          %Player{friends: list(%Player{})}
  def preload_friends(player) do
    ArchivEERepo.preload(player, :friends)
  end

  @spec preload_crews(%Player{}) :: %Player{crews: %Crew{}}
  def preload_crews(player) do
    ArchivEERepo.preload(player, :crews)
  end
end
