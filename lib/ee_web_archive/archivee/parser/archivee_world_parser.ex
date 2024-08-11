defmodule EEWebArchive.ArchivEE.ArchivEEWorldParser do
  alias EEWebArchive.ArchivEE.Parser.BlockColor
  alias EEWebArchive.ArchivEE.BlockType
  alias EEWebArchive.ArchivEE.ByteReader

  def parse_world_data("") do
    nil
  end

  def parse(world_data) when is_bitstring(world_data) do
    IO.inspect(world_data)

    parse_blocks(world_data, [])
    |> IO.inspect(charlists: :as_lists)
  end

  defp parse_blocks(
         <<block_id::integer-32, layer::integer-32, rest::binary>>,
         accum
       ) do
    {xs_positions, rest} = ByteReader.read_ushort_array(rest)
    {ys_positions, rest} = ByteReader.read_ushort_array(rest)
    positions = parse_block_xy_positions(xs_positions, ys_positions)

    block_type = BlockType.get(block_id)
    rest = read_and_ignore_block_type(block_type, rest)

    block_color = BlockColor.get(block_id)

    block = %{
      block_id: block_id,
      layer: layer,
      block_color: block_color,
      positions: positions
    }

    [block | parse_blocks(rest, accum)]
  end

  defp parse_blocks(empty_data, accum) when empty_data == "" do
    accum
  end

  defp parse_block_xy_positions(xs_positions, ys_positions) do
    xs_positions
    |> Enum.zip(ys_positions)
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
        {_, data} = ByteReader.read_utf8_string(data)
        <<_::integer-32, data::binary>> = data
        data

      block_type == :label ->
        {_, data} = ByteReader.read_utf8_string(data)
        {_, data} = ByteReader.read_utf8_string(data)
        <<_::integer-32, data::binary>> = data
        data

      block_type == :npc ->
        {_, data} = ByteReader.read_utf8_string(data)
        {_, data} = ByteReader.read_utf8_string(data)
        {_, data} = ByteReader.read_utf8_string(data)
        {_, data} = ByteReader.read_utf8_string(data)
        data

      true ->
        data
    end
  end
end
