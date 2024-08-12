defmodule EEWebArchive.ArchivEE.MinimapPainter do
  alias ExPng.Image
  alias ExPng.Color

  def paint(block_list, width, height, id) do
    image = Image.new(width, height)

    image =
      Enum.reduce(block_list, image, fn block, acc_image ->
        {r, g, b, _a} = block.color

        color =
          Color.rgb(r, g, b)

        Enum.reduce(block.positions, acc_image, fn {x, y}, acc_image ->
          Image.Drawing.draw(acc_image, {x, y}, color)
        end)
      end)

    path = "./priv/minimaps/#{id}.png"

    Image.to_file(image, path)
  end
end
