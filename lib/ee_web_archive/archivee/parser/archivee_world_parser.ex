defmodule EEWebArchive.ArchivEE.ArchivEEWorldParser do
  alias EEWebArchive.ArchivEE.BlockType
  alias EEWebArchive.ArchivEE.StringReader

  def parse_world_data("") do
    nil
  end

  def parse(world_data) when is_bitstring(world_data) do
    IO.inspect(world_data)

    parse_blocks(world_data, [])
    |> IO.inspect(charlists: :as_lists)
  end

  @doc """
  Recursively parses blocks in the binary ArchivEE world format, appending to the list passed as its 2nd argument.
  """
  defp parse_blocks(
         <<block_id::integer-32, layer::integer-32, xs_length::unsigned-32,
           xs_positions::binary-size(xs_length), ys_length::unsigned-32,
           ys_positions::binary-size(ys_length), rest_of_data::binary>>,
         accumulator
       ) do
    block_type = BlockType.get(block_id)

    read_and_ignore_block_type(block_type, rest_of_data)

    block = %{
      block_id: block_id,
      layer: layer,
      positions: parse_block_x_or_y_positions(xs_positions, ys_positions)
    }

    [block | parse_blocks(rest_of_data, accumulator)]
  end

  defp parse_blocks(empty_data, accumulator) when empty_data == "" do
    accumulator
  end

  defp parse_block_x_or_y_positions(xs_positions, ys_positions) do
    parse_positions(xs_positions)
    |> Enum.zip(parse_positions(ys_positions))
    |> Enum.map(fn {x, y} -> {x, y} end)
  end

  defp parse_positions(positions) do
    positions
    |> :erlang.bitstring_to_list()
    |> Enum.chunk_every(2)
    |> Enum.map(fn [high, low] ->
      <<ushort::16>> = <<high::8, low::8>>
      ushort
    end)
  end

  defp read_and_ignore_block_type(block_type, data) do
    cond do
      block_type == :normal ->
        data

      block_type in [:morphable, :rotatable, :sorta_rotatable, :number, :enum, :music] ->
        <<_::integer-32, data::binary>> = data
        data

      block_type == :portal ->
        <<_::integer-32, _::integer-32, _::integer-32, data::binary>> = data
        data

      block_type in [:sign, :world_portal] ->
        {_whatever, data} = StringReader.read(data)
        <<_::integer-32, data>> = data
        data

      block_type == :label ->
        {_whatever, data} = StringReader.read(data)
        {_whatever, data} = StringReader.read(data)
        <<_::integer-32, data>> = data
        data

      block_type == :npc ->
        {_whatever, data} = StringReader.read(data)
        {_whatever, data} = StringReader.read(data)
        {_whatever, data} = StringReader.read(data)
        {_whatever, data} = StringReader.read(data)
        data

      true ->
        data
    end
  end
end
