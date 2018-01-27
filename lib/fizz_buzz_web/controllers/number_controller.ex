defmodule FizzBuzzWeb.NumberController do
  use FizzBuzzWeb, :controller
  alias FizzBuzz.Numbers.Number

  @pagination_defaults %{"current_page" => 1, "page_size" =>100 }

  def index(conn, %{"format" => "json"} = params) do
    params = merge_pagination_defaults(params)
    render(conn, "index.json", %{numbers: Number.all,
      current_page: params["current_page"],
      page_size: params["page_size"]})
  end

  def index(conn, params) do
    params = merge_pagination_defaults(params)
    conn
    |> assign(:numbers, Number.all)
    |> assign(:current_page, params["current_page"])
    |> assign(:page_size, params["page_size"])
    |> render(:index)
  end

  defp merge_pagination_defaults(args) do
    Map.merge(@pagination_defaults, args, fn _key, default, val -> val || default end)
  end
end