defmodule EEWebArchive.ArchivEE.Crew do
  alias EEWebArchive.ArchivEE
  use Ecto.Schema

  @derive {Jason.Encoder, except: [:__meta__, :player, :members, :worlds]}

  @type t :: %__MODULE__{}

  @primary_key {:rowid, :integer, autogenerate: false}

  schema "crew" do
    field :id, :string
    field :name, :string

    belongs_to :player, ArchivEE.Player, foreign_key: :owner, references: :rowid

    many_to_many :members, ArchivEE.Player,
      join_through: "crew_member",
      join_keys: [crew: :rowid, player: :rowid]

    has_many :worlds, ArchivEE.World, foreign_key: :crew
  end
end
