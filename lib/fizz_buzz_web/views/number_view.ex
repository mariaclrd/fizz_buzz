defmodule FizzBuzzWeb.NumberView do
  def render("index.json", %{numbers: numbers}) do
    %{entries: Enum.map(numbers, &as_json/1)}
  end

  def as_json(number) do
    %{
      number: number
    }
  end
end