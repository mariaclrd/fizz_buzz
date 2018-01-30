defmodule FizzBuzzWeb.NumberView do
  use FizzBuzzWeb, :view
  alias FizzBuzz.Numbers.Pagination
  alias FizzBuzz.Numbers.Number


  def render("index.json", %{numbers: numbers, current_page: current_page, page_size: page_size}) do
    %{
      entries: numbers,
      pagination: pagination(page_size, current_page)
    }
  end

  defp pagination(page_size, current_page) do
    %{
      total_entries: Pagination.total_entries(Number.all),
      total_pages: Pagination.total_pages(Number.all, page_size),
      current_page: current_page
    }
  end
end