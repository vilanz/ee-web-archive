defmodule EEWebArchive.ArchivEE.WorldData do
  use Ecto.Schema

  @type t :: %__MODULE__{}

  @primary_key {:rowid, :integer, autogenerate: false}

  schema "_world_data_zstd" do
    field :data, :binary

    belongs_to :world, ArchivEE.World,
      foreign_key: :rowid,
      references: :data_ref,
      define_field: false
  end
end
