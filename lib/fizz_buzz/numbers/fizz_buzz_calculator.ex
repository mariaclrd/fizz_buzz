defmodule FizzBuzz.Numbers.FizzBuzzCalculator do
  def for(number) do
    whichfizz(rem(number, 3), rem(number, 5), number)
  end

  defp whichfizz(0, 0, _) do "FizzBuzz" end
  defp whichfizz(0, _, _) do "Fizz" end
  defp whichfizz(_, 0, _) do "Buzz" end
  defp whichfizz(_, _, number) do number end
end