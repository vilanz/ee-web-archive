defmodule ArchivEE.Player do
  use Ecto.Schema
  @primary_key {:rowid, :integer, autogenerate: false}

  schema "player" do
		field :id, :string
		field :name, :string
		field :energy, :integer
		field :created, :utc_datetime
		field :last_login, :utc_datetime
  end
end
