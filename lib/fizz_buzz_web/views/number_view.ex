defmodule FizzBuzzWeb.NumberView do
  use FizzBuzzWeb, :view
  alias FizzBuzz.Numbers.Pagination
  alias FizzBuzz.Numbers.Number

  def entries(%{numbers: numbers, current_page: current_page, page_size: page_size}) do
    Pagination.entries(numbers, current_page, page_size)
  end

  def render("index.json", %{numbers: numbers, current_page: current_page, page_size: page_size} = params) do
    %{
      entries: entries(params) |> Enum.map(&as_json/1),
      pagination: pagination(numbers, page_size, current_page)
    }
  end

  def is_favourite(number) do
    Number.is_favourite(number)
  end

  def fizz_buzz_value(number) do
    Number.fizz_buzz(number)
  end

  defp as_json(number) do
    %{
      number: number,
      fizz_buzz_value: fizz_buzz_value(number),
      favourite: is_favourite(number)
    }
  end

  defp pagination(numbers, page_size \\ 100, current_page \\ 1) do
    %{
      total_entries: Pagination.total_entries(numbers),
      total_pages: Pagination.total_pages(numbers, page_size),
      current_page: current_page
    }
  end
end