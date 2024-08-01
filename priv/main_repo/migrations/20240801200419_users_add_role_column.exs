defmodule EEWebArchive.MainRepo.Migrations.UsersAddRoleColumn do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :role, :string
    end
  end
end
