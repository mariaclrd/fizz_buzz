defmodule FizzBuzzWeb.FavouriteViewTest do
  use FizzBuzzWeb.ConnCase, async: true
  alias FizzBuzz.Repo
  alias FizzBuzz.Favourites.Favourite
  alias FizzBuzzWeb.FavouriteView

  describe "render create.json" do
    test "returns an empty body" do
      assert FavouriteView.render("create.json") == ""
    end
  end

  describe "render show.json" do
    test "returns the favourite on json" do
      {:ok, favourite} = Repo.insert(%Favourite{number: 12})
      json_favourite = FavouriteView.render("show.json", %{favourite: favourite})

      assert json_favourite ==  %{id: favourite.id, number: favourite.number}
    end
  end
end