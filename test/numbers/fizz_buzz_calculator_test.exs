defmodule FizzBuzz.Numbers.FizzBuzzCalculatorTest do
  use ExUnit.Case
  alias FizzBuzz.Numbers.FizzBuzzCalculator

  describe "for" do
    test "returns the same number if is not divisible by 3 or 5" do
      assert FizzBuzzCalculator.for(1) == 1
    end

    test "returns Fizz is the number can be divided by 3" do
      assert FizzBuzzCalculator.for(3) == "Fizz"
    end

    test "returns Buzz is the number can be divided by 5" do
      assert FizzBuzzCalculator.for(5) == "Buzz"
    end

    test "returns FizzBuzz is the number can be divided by 3 and 5" do
      assert FizzBuzzCalculator.for(15) == "FizzBuzz"
    end
  end
end