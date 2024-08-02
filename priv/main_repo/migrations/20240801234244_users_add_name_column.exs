defmodule EEWebArchive.MainRepo.Migrations.UsersAddNameColumn do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :name, :string, null: false
    end

    create unique_index(:users, [:name])
  end
end
