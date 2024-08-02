defmodule EEWebArchive.ArchivEERepo do
  use Ecto.Repo, otp_app: :ee_web_archive, adapter: Ecto.Adapters.SQLite3, read_only: true
end
