defmodule FizzBuzzWeb.NumberView do
  use FizzBuzzWeb, :view
  alias FizzBuzz.Numbers.Pagination
  
  def render("index.json", %{numbers: numbers, entries: entries, current_page: current_page, page_size: page_size}) do
    %{
      entries: entries,
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