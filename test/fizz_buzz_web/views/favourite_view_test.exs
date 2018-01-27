defmodule FizzBuzzWeb.FavouriteViewTest do
  use FizzBuzzWeb.ConnCase, async: true

  alias FizzBuzzWeb.FavouriteView

  describe "render create.json" do
    test "returns an empty body" do
      assert FavouriteView.render("create.json") == ""
    end
  end
end