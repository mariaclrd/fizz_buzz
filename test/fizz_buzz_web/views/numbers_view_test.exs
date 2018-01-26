defmodule FizzBuzzWeb.NumbersViewTest do
  use FizzBuzzWeb.ConnCase, async: true

  alias FizzBuzzWeb.NumbersView

  test "as_json" do
    json_number = NumbersView.as_json(1)

    assert json_number == %{
             number: 1
           }
  end

  test "render index.json" do
    json_numbers = NumbersView.render("index.json", %{numbers: [1, 2]})

    assert json_numbers == %{
             entries: [%{number: 1}, %{number: 2}]
           }
  end


end
