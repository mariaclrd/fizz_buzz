defmodule FizzBuzzWeb.NumberController do
  use FizzBuzzWeb, :controller
  alias FizzBuzz.Numbers.Number
  alias FizzBuzz.Numbers.Pagination
  alias FizzBuzz.Numbers.FizzBuzzCalculator
  alias FizzBuzz.Favourites.Favourite

  @pagination_defaults %{"current_page" => 1, "page_size" =>100 }

  def index(conn, %{"format" => "json"} = params) do
    params = merge_pagination_defaults(params)

    entries = Number.all
              |> Pagination.entries(params["current_page"], params["page_size"])
              |> Favourite.for_numbers
              |> FizzBuzzCalculator.for_numbers

    render(conn, "index.json", %{numbers: Number.all, entries: entries,
      current_page: params["current_page"],
      page_size: params["page_size"]})
  end

  def index(conn, params) do
    params = merge_pagination_defaults(params)
    entries = Number.all
              |> Pagination.entries(params["current_page"], params["page_size"])
              |> Favourite.for_numbers
              |> FizzBuzzCalculator.for_numbers
    conn
    |> assign(:entries, entries)
    |> assign(:current_page, to_integer(params["current_page"]))
    |> assign(:page_size, to_integer(params["page_size"]))
    |> render(:index)
  end

  defp merge_pagination_defaults(args) do
    Map.merge(@pagination_defaults, args, fn _key, default, val -> to_integer(val) || default end)
  end

  defp to_integer(value) when is_integer(value) do
    value
  end

  defp to_integer(value) do
    String.to_integer(value)
  end
end