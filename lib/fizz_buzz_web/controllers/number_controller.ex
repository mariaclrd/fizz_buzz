defmodule FizzBuzzWeb.NumberController do
  use FizzBuzzWeb, :controller
  alias FizzBuzz.Numbers.Number

  def index(conn, params) do
    render(conn, "index.json", %{numbers: Number.all,
      current_page: params["current_page"],
      page_size: params["page_size"]})
  end
end