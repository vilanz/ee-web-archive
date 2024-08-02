defmodule EEWebArchive.ArchivEE.Players do
  alias EEWebArchive.ArchivEERepo
  alias EEWebArchive.ArchivEE

  def get_by_name(name) when is_binary(name) do
    ArchivEERepo.get_by(ArchivEE.Player, name: name)
  end
end
