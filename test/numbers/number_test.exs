defmodule FizzBuzz.Numbers.NumberTest do
  use ExUnit.Case
  use FizzBuzz.DataCase
  alias FizzBuzz.Numbers.Number
  alias FizzBuzz.Favourites.Favourite

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Repo, {:shared, self()})
    :ok
  end

  describe "is_favourite" do
    test "returns true if the number is stored as favourite on the database" do
      Favourite.create(%{number: 1})
      assert Number.is_favourite(1) == true
    end

    test "returns false if the number is not stored as favourite on the database" do
      assert Number.is_favourite(1) == false
    end
  end

  describe "fizz_buzz value" do
    test "returns the fizz buzz value" do
      assert Number.fizz_buzz(1) == 1
      assert Number.fizz_buzz(3) == "Fizz"
      assert Number.fizz_buzz(5) == "Buzz"
      assert Number.fizz_buzz(15) == "FizzBuzz"
    end
  end
end