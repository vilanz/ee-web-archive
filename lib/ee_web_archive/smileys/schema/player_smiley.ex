defmodule EEWebArchive.Smileys.PlayerSmiley do
  use Ecto.Schema

  @type t :: %__MODULE__{}

  @primary_key {:player_id, :string, autogenerate: false}

  schema "smileys" do
    field :smiley_id, :integer
  end
end
