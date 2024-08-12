defmodule EEWebArchive.ArchivEE.MinimapPainter do
  alias ExPng.Image
  alias ExPng.Color

  def paint(block_list, width, height, id) do
    image = Image.new(width, height)

    image =
      Enum.reduce(block_list, image, fn block, acc_image ->
        paint_block(acc_image, block)
      end)

    path = "./priv/minimaps/#{id}.png"

    Image.to_file(image, path)
  end

  @spec paint_block(Image.t(), any()) :: Image.t()
  defp paint_block(image, block) do
    {r, g, b, _a} = block.color
    IO.inspect("aaa")

    color =
      Color.rgb(r, g, b)

    Enum.reduce(block.positions, image, fn {x, y}, acc_image ->
      Image.Drawing.draw(acc_image, {x, y}, color)
    end)
  end
end
