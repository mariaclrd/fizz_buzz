defmodule FizzBuzzWeb.NumberController do
  use FizzBuzzWeb, :controller
  alias FizzBuzz.Numbers.Number

  def index(conn, %{"format" => "json"} = params) do
    render(conn, "index.json", %{numbers: Number.all,
      current_page: params["current_page"],
      page_size: params["page_size"]})
  end

  def index(conn, params) do
    conn
    |> assign(:numbers, Number.all)
    |> assign(:current_page, params["current_page"])
    |> assign(:page_size, params["page_size"])
    |> render :index
  end
end