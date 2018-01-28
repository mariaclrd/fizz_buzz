defmodule FizzBuzzWeb.FavouriteView do
  use FizzBuzzWeb, :view

  def render("create.json", _params) do
    ""
  end

  def render("show.json", %{favourite: favourite}) do
    %{
      id: favourite.id,
      number: favourite.number
    }
  end
end