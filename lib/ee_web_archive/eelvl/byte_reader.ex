defmodule EEWebArchive.EELVL.ByteReader do
  def read_utf8_string(
        <<string_length::unsigned-integer-16, string::binary-size(string_length), rest::binary>>
      ),
      do: {string, rest}
end
