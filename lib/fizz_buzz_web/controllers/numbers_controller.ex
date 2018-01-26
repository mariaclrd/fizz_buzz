defmodule FizzBuzzWeb.NumbersController do
  use FizzBuzzWeb, :controller

  def index(conn, _params) do
    render(conn, "index.json", %{})
  end
end