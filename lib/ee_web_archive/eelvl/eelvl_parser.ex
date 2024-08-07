defmodule EEWebArchive.EELVL.Parser do
  alias EEWebArchive.EELVL.ByteReader

  def parse_world_data("") do
    nil
  end

  def parse_world_data(world_data) when is_bitstring(world_data) do
    IO.inspect(world_data)
    {str, _rest} = ByteReader.read_utf8_string(world_data)

    IO.inspect(str)
    %{name: str}
  end
end
