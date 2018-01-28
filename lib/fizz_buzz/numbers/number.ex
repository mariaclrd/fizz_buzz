defmodule FizzBuzz.Numbers.Number do
  alias FizzBuzz.Favourites.Favourite
  alias FizzBuzz.Numbers.FizzBuzzCalculator

  def all do
    1..100_000_000_000
  end

  def is_favourite(number) do
    case Favourite.find_by_number(number) do
      {:ok, _} -> true
      {:error, _} -> false
    end
  end

  def fizz_buzz(number) do
    FizzBuzzCalculator.for(number)
  end
end
