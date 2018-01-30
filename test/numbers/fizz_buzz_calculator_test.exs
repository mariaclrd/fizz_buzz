defmodule FizzBuzz.Numbers.FizzBuzzCalculatorTest do
  use ExUnit.Case
  alias FizzBuzz.Numbers.FizzBuzzCalculator

  describe "for" do
    test "returns the same number if is not divisible by 3 or 5" do
      assert FizzBuzzCalculator.calculate_for(1) == 1
    end

    test "returns Fizz is the number can be divided by 3" do
      assert FizzBuzzCalculator.calculate_for(3) == "Fizz"
    end

    test "returns Buzz is the number can be divided by 5" do
      assert FizzBuzzCalculator.calculate_for(5) == "Buzz"
    end

    test "returns FizzBuzz is the number can be divided by 3 and 5" do
      assert FizzBuzzCalculator.calculate_for(15) == "FizzBuzz"
    end
  end

  describe "set for" do
    test "sets the fizzbuzz values on the map" do
      assert  FizzBuzzCalculator.for_numbers([%{number: 1}, %{number: 3}]) == [%{number: 1, fizz_buzz_value: 1}, %{number: 3, fizz_buzz_value: "Fizz"}]
    end
  end
end