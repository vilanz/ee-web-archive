defmodule EEWebArchive.ArchivEE.WorldData do
  alias EEWebArchive.ArchivEE
  use Ecto.Schema

  @derive {Jason.Encoder, except: [:__meta__, :world]}

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
