defmodule FizzBuzzWeb.NumberView do
  def render("index.json", %{numbers: numbers}) do
    %{
      entries: Enum.map(numbers, &as_json/1),
      pagination: pagination(numbers)
    }
  end

  def as_json(number) do
    %{
      number: number
    }
  end

  def pagination(numbers, page_size\\10, current_page\\1) do
    %{
      total_entries: length(numbers),
      total_pages: total_pages(numbers, page_size),
      current_page: current_page
    }
  end

  defp total_pages(numbers, page_size\\10) do
    length(numbers)
    |> (Kernel./page_size)
    |> Float.ceil
    |> Kernel.trunc
  end
end