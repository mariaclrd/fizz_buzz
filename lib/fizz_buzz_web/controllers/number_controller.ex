defmodule FizzBuzzWeb.NumberController do
  use FizzBuzzWeb, :controller
  alias FizzBuzz.Numbers.Number

  def index(conn, _params) do
    render(conn, "index.json", %{numbers: Number.all})
  end
end