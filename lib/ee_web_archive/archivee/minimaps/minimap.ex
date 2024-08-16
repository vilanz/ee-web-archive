defmodule EEWebArchive.ArchivEE.Minimaps.Minimap do
  alias EEWebArchive.ArchivEE.WorldParser.Block

  @spec generate(block_list :: list(Block.t()), width :: integer(), height :: integer()) ::
          iolist()
  def generate(block_list, width, height) do
    arr = :array.new(size: width * height, default: {0, 0, 0})

    image =
      Enum.reduce(block_list, arr, fn block, acc_image ->
        {r, g, b, _a} = block.color

        Enum.reduce(block.positions, acc_image, fn {x, y}, acc_image ->
          :array.set(y * width + x, {r, g, b}, acc_image)
        end)
      end)

    Pngex.new(type: :rgb, width: width, height: height)
    |> Pngex.generate(image |> :array.to_list())
  end

  def path(world_rowid) do
    "/srv/ee-web-archive/archivee-minimaps/#{world_rowid}.png"
  end
end
