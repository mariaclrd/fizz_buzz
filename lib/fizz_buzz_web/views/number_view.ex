defmodule FizzBuzzWeb.NumberView do
  alias FizzBuzz.Numbers.Pagination
  alias FizzBuzz.Numbers.Number

  def render("index.json", %{numbers: numbers}) do
    %{
      entries: Pagination.entries(numbers) |> Enum.map(&as_json/1),
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
      total_entries: Pagination.total_entries(numbers),
      total_pages: Pagination.total_pages(numbers, page_size),
      current_page: current_page
    }
  end
end