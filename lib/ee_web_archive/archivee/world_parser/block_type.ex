defmodule EEWebArchive.ArchivEE.WorldParser.BlockType do
  alias EEWebArchive.ArchivEE.ByteReader

  @morphable_blocks [
    327,
    328,
    273,
    440,
    276,
    277,
    279,
    280,
    447,
    449,
    450,
    451,
    452,
    456,
    457,
    458,
    464,
    465,
    471,
    477,
    475,
    476,
    481,
    482,
    483,
    497,
    492,
    493,
    494,
    1502,
    1500,
    1507,
    1506,
    1581,
    1587,
    1588,
    1592,
    1593,
    1160,
    1594,
    1595,
    1597
  ]

  @rotatable_blocks [
    375,
    376,
    379,
    380,
    377,
    378,
    438,
    439,
    1001,
    1002,
    1003,
    1004,
    1052,
    1053,
    1054,
    1055,
    1056,
    1092,
    275,
    329,
    338,
    339,
    340,
    448,
    1536,
    1537,
    1041,
    1042,
    1043,
    1075,
    1076,
    1077,
    1078,
    499,
    1116,
    1117,
    1118,
    1119,
    1120,
    1121,
    1122,
    1123,
    1124,
    1125,
    1535,
    1135,
    1134,
    1538,
    1140,
    1141,
    1155,
    1596,
    1605,
    1606,
    1607,
    1609,
    1610,
    1611,
    1612,
    1614,
    1615,
    1616,
    1617,
    361,
    1625,
    1627,
    1629,
    1631,
    1633,
    1635
  ]

  @sorta_rotatable_blocks [1101, 1102, 1103, 1104, 1105]

  @number_blocks [
    165,
    43,
    213,
    214,
    1011,
    1012,
    113,
    1619,
    184,
    185,
    467,
    1620,
    1079,
    1080,
    1582,
    421,
    422,
    461,
    1584
  ]

  @enum_blocks [423, 1027, 1028, 418, 417, 420, 419, 453, 1517]

  @music_blocks [83, 77, 1520]

  @portal_blocks [381, 242]

  @world_portal_block 374

  @sign_block 385

  @label_block 1000

  @npc_blocks [
    1550,
    1551,
    1552,
    1553,
    1554,
    1555,
    1556,
    1557,
    1558,
    1559,
    1569,
    1570,
    1571,
    1572,
    1573,
    1574,
    1575,
    1576,
    1577,
    1578,
    1579
  ]

  def get(block_id) when block_id in @morphable_blocks, do: :morphable

  def get(block_id) when block_id in @rotatable_blocks, do: :rotatable

  def get(block_id) when block_id in @sorta_rotatable_blocks,
    do: :sorta_rotatable

  def get(block_id) when block_id in @number_blocks,
    do: :number

  def get(block_id) when block_id in @enum_blocks,
    do: :enum

  def get(block_id) when block_id in @music_blocks,
    do: :music

  def get(block_id) when block_id in @portal_blocks,
    do: :portal

  def get(block_id) when block_id == @world_portal_block,
    do: :world_portal

  def get(block_id) when block_id == @sign_block,
    do: :sign

  def get(block_id) when block_id == @label_block,
    do: :label

  def get(block_id) when block_id in @npc_blocks,
    do: :npc

  def get(_block_id), do: :normal

  def read_and_ignore_block_type(block_type, data) do
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
