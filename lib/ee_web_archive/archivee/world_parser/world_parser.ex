defmodule EEWebArchive.ArchivEE.WorldParser do
  alias EEWebArchive.ArchivEE.WorldParser.BlockColor
  alias EEWebArchive.ArchivEE.WorldParser.BlockType
  alias EEWebArchive.ArchivEE.WorldParser.Block
  alias EEWebArchive.ArchivEE.ByteReader

  @spec parse_world_data(<<>>) :: nil
  def parse_world_data("") do
    nil
  end

  @spec parse(bitstring()) :: list(Block.t())
  def parse(world_data) when is_bitstring(world_data) do
    parse_blocks(world_data, [])
    |> Enum.sort_by(&{&1.layer}, :desc)
  end

  defp parse_blocks(
         <<block_id::integer-32, layer::integer-32, rest::binary>>,
         accum
       ) do
    {xs_positions, rest} = ByteReader.read_ushort_array(rest)
    {ys_positions, rest} = ByteReader.read_ushort_array(rest)

    positions =
      xs_positions
      |> Enum.zip(ys_positions)

    block_type = BlockType.get(block_id)
    rest = read_and_ignore_block_type(block_type, rest)

    color = BlockColor.get(block_id)
    color_alpha = elem(color, 3)

    if color_alpha != 255 do
      # Ignore transparent/unknown blocks
      parse_blocks(rest, accum)
    else
      block = %Block{
        id: block_id,
        layer: layer,
        color: color,
        positions: positions
      }

      [block] ++ parse_blocks(rest, accum)
    end
  end

  defp parse_blocks(empty_data, accum) when empty_data == "" do
    accum
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
