defmodule FizzBuzzWeb.NumberView do
  use FizzBuzzWeb, :view
  alias FizzBuzz.Numbers.Pagination
  alias FizzBuzz.Numbers.FizzBuzzCalculator

  def entries(args) do
    collection_as_json(args)[:entries]
  end

  def render("index.json", %{numbers: numbers, current_page: current_page, page_size: page_size}) do
    collection_as_json(%{numbers: numbers, current_page: current_page, page_size: page_size})
  end

  def collection_as_json(%{numbers: numbers, current_page: current_page, page_size: page_size}) do
    %{
      entries: Pagination.entries(numbers, current_page, page_size) |> Enum.map(&as_json/1),
      pagination: pagination(numbers, page_size, current_page)
    }
  end

  def as_json(number) do
    %{
      number: number,
      fizz_buzz_value: FizzBuzzCalculator.for(number)
    }
  end

  def pagination(numbers, page_size \\ 100, current_page \\ 1) do
    %{
      total_entries: Pagination.total_entries(numbers),
      total_pages: Pagination.total_pages(numbers, page_size),
      current_page: current_page
    }
  end
end