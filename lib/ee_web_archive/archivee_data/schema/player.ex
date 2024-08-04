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

    many_to_many :crews, ArchivEE.Crew,
      join_through: "crew_member",
      join_keys: [player: :rowid, crew: :rowid]

    many_to_many :friends, ArchivEE.Player,
      join_through: "player_friend",
      join_keys: [player_1: :rowid, player_2: :rowid]
  end
end
