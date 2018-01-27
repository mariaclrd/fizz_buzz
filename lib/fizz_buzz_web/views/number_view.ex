defmodule FizzBuzzWeb.NumberView do
  alias FizzBuzz.Numbers.Pagination
  alias FizzBuzz.Numbers.FizzBuzzCalculator

  @pagination_defaults %{current_page: 1, page_size: 100}

  def render("index.json", args) do
    %{numbers: numbers, current_page: current_page, page_size: page_size} = merge_pagination_defaults(args)
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

  defp merge_pagination_defaults(args) do
    Map.merge(@pagination_defaults, args, fn _key, default, val -> val || default end)
  end
end