defmodule EEWebArchive.ReleaseTasks do
  alias EEWebArchive.Accounts

  def create_admin_user(email, name, password) do
    Application.ensure_all_started(:ee_web_archive)
    user_params = %{
      :email => email,
      :name => name,
      :password => password,
      :role => :admin
    }
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        IO.inspect(user)
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &"/users/confirm/#{&1}"
          )

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.puts(changeset)
    end
  end
end
