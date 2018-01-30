defmodule FizzBuzzWeb.NumberView do
  use FizzBuzzWeb, :view
  alias FizzBuzz.Numbers.Pagination
  alias FizzBuzz.Numbers.FizzBuzzCalculator
  alias FizzBuzz.Favourites.Favourite

  def entries(%{numbers: numbers, current_page: current_page, page_size: page_size}) do
    Pagination.entries(numbers, current_page, page_size) |> Favourite.for_numbers |> FizzBuzzCalculator.for_numbers
  end

  def render("index.json", %{numbers: numbers, current_page: current_page, page_size: page_size} = params) do
    %{
      entries: entries(params),
      pagination: pagination(numbers, page_size, current_page)
    }
  end

  defp pagination(numbers, page_size, current_page) do
    %{
      total_entries: Pagination.total_entries(numbers),
      total_pages: Pagination.total_pages(numbers, page_size),
      current_page: current_page
    }
  end
end