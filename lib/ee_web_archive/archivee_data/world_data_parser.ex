defmodule EEWebArchive.ArchivEE.WorldDataParser do
  use Rustler, otp_app: :ee_web_archive, crate: "world_data_parser"

  # When your NIF is loaded, it will override this function.
  def add(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
end
