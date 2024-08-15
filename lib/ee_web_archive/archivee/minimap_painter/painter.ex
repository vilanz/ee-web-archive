defmodule EEWebArchive.ArchivEE.MinimapPainter do
  def paint(block_list, width, height, id) do
    arr = :array.new(size: width * height, default: {0, 0, 0})

    image =
      Enum.reduce(block_list, arr, fn block, acc_image ->
        {r, g, b, _a} = block.color

        Enum.reduce(block.positions, acc_image, fn {x, y}, acc_image ->
          :array.set(y * width + x, {r, g, b}, acc_image)
        end)
      end)

    image =
      Pngex.new(type: :rgb, width: width, height: height)
      |> Pngex.generate(image |> :array.to_list())

    path = "/srv/ee-web-archive/archivee-minimaps/#{id}.png"
    File.write!(path, image)
  end
end
