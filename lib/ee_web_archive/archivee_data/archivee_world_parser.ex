defmodule EEWebArchive.ArchivEE.ArchivEEWorldParser do
  def parse_world_data("") do
    nil
  end

  def parse(world_data) when is_bitstring(world_data) do
    IO.inspect(world_data)

    parse_blocks(world_data, [])
    |> IO.inspect()
  end

  defp parse_blocks(
         <<block_id::integer-32, layer::integer-32, xs_length::unsigned-32,
           xs_positions::binary-size(xs_length), ys_length::unsigned-32,
           ys_positions::binary-size(ys_length), rest::binary>>,
         accumulator
       ) do
    block = %{
      block_id: block_id,
      layer: layer,
      xs_length: xs_length,
      xs_positions: xs_positions,
      ys_length: ys_length,
      ys_positions: ys_positions
    }

    [block | parse_blocks(rest, accumulator)]
  end

  defp parse_blocks(invalid, accumulator) do
    accumulator
  end
end
