defmodule EEWebArchiveWeb.HTMLHelpers do
  def format_number(number) do
    Number.Delimit.number_to_delimited(number, precision: 0)
  end
end
