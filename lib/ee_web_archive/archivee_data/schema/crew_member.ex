defmodule EEWebArchive.ArchivEE.Crew do
  alias EEWebArchive.ArchivEE
  use Ecto.Schema

  @primary_key {:rowid, :integer, autogenerate: false}

  schema "crew_member" do
    field :id, :string
    field :name, :string

    belongs_to :player, ArchivEE.Player, foreign_key: :owner, references: :rowid
  end
end
