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

    test "only insert the record once" do
      Favourite.create(%{number: 12})
      Favourite.create(%{number: 12})
      assert length(Repo.all(Favourite)) == 1
    end
  end

  describe "find_by_number" do
    test "returns the favourite if is found by number" do
      {:ok, _favourite} = Repo.insert(%Favourite{number: 12})
      {:ok, resource} = Favourite.find_by_number(12)

      assert is_nil(resource) == false
    end

    test "returns an error is favourite is not found" do
      {:error, message} = Favourite.find_by_number(12)

      assert message == :not_found
    end
  end

  describe "find_for_numbers" do
    test "returns the collection of favourites associated to the numbers" do
      {:ok, favourite_one} =  Favourite.create(%{number: 1})
      {:ok, favourite_two} = Favourite.create(%{number: 2})
      {:ok, favourites} = Favourite.find_for_numbers([1,2])
      assert favourites |> Enum.map(&(&1.id)) == [favourite_one.id, favourite_two.id]
    end

    test "returns empty array if any number of the collection has a favourite" do
      {:ok, favourites} = Favourite.find_for_numbers([1,2])
      assert favourites == []
    end
  end

  describe "for numbers" do
    test "push the found favourite to the map" do
      {:ok, _} =  Favourite.create(%{number: 1})

      assert  Favourite.for_numbers([%{number: 1}, %{number: 2}]) == [%{number: 1, favourite: true}, %{number: 2, favourite: false}]
    end
  end
end