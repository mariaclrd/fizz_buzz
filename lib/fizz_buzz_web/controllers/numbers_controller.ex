defmodule FizzBuzzWeb.NumbersController do
  use FizzBuzzWeb, :controller

  def index(conn, _params) do
    render(conn, "index.json", %{numbers: [1]})
  end
end