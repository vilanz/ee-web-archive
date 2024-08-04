defmodule EEWebArchive.ArchivEE.World do
  alias EEWebArchive.ArchivEE
  use Ecto.Schema

  @primary_key {:rowid, :integer, autogenerate: false}

  schema "world" do
    field :id, :string
    field :name, :string
    field :created, :utc_datetime
    field :plays, :integer
    field :description, :string
    field :width, :integer
    field :height, :integer
    field :background_color, :integer
    field :gravity, :float
    field :minimap, :boolean
    field :empty, :boolean

    belongs_to :player, ArchivEE.World, foreign_key: :owner, references: :rowid

    field :data_ref, :integer
    has_one :data_entity, ArchivEE.WorldData, foreign_key: :rowid, references: :data_ref
  end
end
