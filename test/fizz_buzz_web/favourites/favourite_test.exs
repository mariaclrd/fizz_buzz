defmodule FizzBuzz.Favourites.FavouriteTest do
  use ExUnit.Case
  use FizzBuzz.DataCase
  alias FizzBuzz.Favourites.Favourite


  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Repo, {:shared, self()})
    :ok
  end

  describe "find_by_id" do
    test "receives an id an returns the favourite of the database" do
      {:ok, favourite} = Repo.insert(%Favourite{number: 12})
      {:ok, resource} = Favourite.find_by_id(favourite.id)
      assert resource.number == 12
    end

    test "returns an error when record cannot be found" do
      {:error, message} = Favourite.find_by_id(100)
      assert message == :not_found
    end
  end

  describe "create" do
    test "inserts a favourite on the database" do
      Favourite.create(%{number: 12})
      assert length(Repo.all(Favourite)) == 1
    end

    test "returns an error if the params are not valid" do
      {:error, value} = Favourite.create(%{number: "blah"})
      assert value == :invalid
    end
  end
end