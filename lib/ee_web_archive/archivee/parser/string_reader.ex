defmodule EEWebArchive.ArchivEE.StringReader do
  def read(<<length::unsigned-16, bin_string::binary-size(length), rest::binary>>) do
    {bin_string, rest}
  end
end
