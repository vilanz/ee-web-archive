defmodule EEWebArchive.ArchivEE.WorldParser.BlockColor do
  @type t :: {integer(), integer(), integer(), integer()}

  @block_colors :ee_web_archive
                |> :code.priv_dir()
                |> Path.join("data/block_colors.csv")
                |> File.stream!()
                |> CSV.decode!(headers: false, separator: ?,)
                |> Enum.reduce(%{}, fn [block_id, r, g, b, a], acc ->
                  Map.put(
                    acc,
                    String.to_integer(block_id),
                    {String.to_integer(r), String.to_integer(g), String.to_integer(b),
                     String.to_integer(a)}
                  )
                end)

  @spec get(block_id :: integer()) :: t()
  def get(block_id) do
    Map.get(@block_colors, block_id, {0, 0, 0, 0})
  end
end
