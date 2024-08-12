defmodule EEWebArchive.ArchivEE.ByteReader do
  def read_utf8_string(<<length::unsigned-16, bin_string::binary-size(length), rest::binary>>) do
    {bin_string, rest}
  end

  def read_ushort_array(<<length::unsigned-32, array::binary-size(length), rest::binary>>) do
    ushort_array = parse_ushort_array(array)
    {ushort_array, rest}
  end

  defp parse_ushort_array(array) do
    array
    |> :erlang.bitstring_to_list()
    |> Enum.chunk_every(2)
    |> Enum.map(fn [high, low] ->
      <<ushort::16>> = <<high::8, low::8>>
      ushort
    end)
  end
end
