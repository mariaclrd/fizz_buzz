defmodule FizzBuzzWeb.NumberViewTest do
  use FizzBuzzWeb.ConnCase, async: true
  alias FizzBuzzWeb.NumberView

  describe "entries" do
    test "only returns the entries" do
      entries = NumberView.entries(%{numbers: [1], current_page: 1, page_size: 1})
      assert entries == [%{number: 1, favourite: false, fizz_buzz_value: 1}]
    end

    test "allows to specify a number" do
      entries = NumberView.entries(%{numbers: [1,2,3,4,5], current_page: 1, page_size: 2})
      assert entries == [%{number: 1, favourite: false, fizz_buzz_value: 1}, %{number: 2, favourite: false, fizz_buzz_value: 2}]
    end
  end

  describe "render index.json" do

    test "returns the entries" do
      json_numbers = NumberView.render("index.json", %{numbers: [1, 2], current_page: 1, page_size: 5})

      assert json_numbers[:entries] ==  [%{number: 1, fizz_buzz_value: 1, favourite: false},
               %{number: 2, fizz_buzz_value: 2, favourite: false}]
    end


    test "renders the pagination" do
      json_numbers = NumberView.render("index.json", %{numbers: [1, 2], current_page: 1, page_size: 5})

      assert json_numbers[:pagination] == %{total_entries: 2, total_pages: 1, current_page: 1}
    end
  end
end