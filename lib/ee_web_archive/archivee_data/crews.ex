defmodule EEWebArchive.ArchivEE.Crews do
  alias EEWebArchive.ArchivEERepo
  alias EEWebArchive.ArchivEE.Crew
  alias EEWebArchive.ArchivEE.Player
  alias EEWebArchive.ArchivEE.World

  def get_by_id(id) do
    ArchivEERepo.get_by(Crew, id: id)
  end

  @spec preload_members(%Crew{}) ::
          %Crew{members: list(%Player{})}
  def preload_members(crew) do
    ArchivEERepo.preload(crew, :members)
  end

  @spec preload_worlds(%Crew{}) :: %Crew{worlds: list(%World{})}
  def preload_worlds(crew) do
    ArchivEERepo.preload(crew, worlds: [:data_entity])
  end
end
