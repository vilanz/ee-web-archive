defmodule EEWebArchive.MainRepo.Migrations.UsersMakeRoleNotNull do
  use Ecto.Migration

  def change do
    alter table("users") do
      modify :role, :string, null: false, from: {:string, null: true}
    end
  end
end
