defmodule EEWebArchive.ArchivEE.Player do
  alias EEWebArchive.ArchivEE
  use Ecto.Schema

  @primary_key {:rowid, :integer, autogenerate: false}

  schema "player" do
    field :id, :string
    field :name, :string
    field :energy, :integer
    field :created, :utc_datetime
    field :last_login, :utc_datetime
    has_many :worlds, ArchivEE.World, foreign_key: :owner
  end
end
