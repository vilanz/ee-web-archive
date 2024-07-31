defmodule EEWebArchive.Repo do
  use Ecto.Repo,
    otp_app: :ee_web_archive,
    adapter: Ecto.Adapters.Postgres
end
