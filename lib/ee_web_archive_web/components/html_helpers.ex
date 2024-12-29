defmodule EEWebArchiveWeb.HTMLHelpers do
  @spec format_number(number()) :: String.t()
  def format_number(number) do
    Number.Delimit.number_to_delimited(number, precision: 0)
  end

  @spec format_date(DateTime.t() | nil) :: String.t()
  def format_date(date) do
    if date == nil do
      "Unknown"
    else
      Calendar.strftime(date, " %B %-d, %Y")
    end
  end
end
