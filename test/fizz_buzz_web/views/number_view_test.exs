defmodule FizzBuzzWeb.NumberViewTest do
  use FizzBuzzWeb.ConnCase, async: true
  alias FizzBuzzWeb.NumberView

  describe "render index.json" do

    test "returns the entries" do
      entries = [%{number: 1, fizz_buzz_value: 1, favourite: false}, %{number: 2, fizz_buzz_value: 2, favourite: false}]
      json_numbers = NumberView.render("index.json", %{numbers: [1,2], entries: entries, current_page: 1, page_size: 5})

      assert json_numbers[:entries] ==  [%{number: 1, fizz_buzz_value: 1, favourite: false},
               %{number: 2, fizz_buzz_value: 2, favourite: false}]
    end


    test "renders the pagination" do
      json_numbers = NumberView.render("index.json", %{numbers: [1, 2], entries: %{}, current_page: 1, page_size: 5})

      assert json_numbers[:pagination] == %{current_page: 1, total_entries: 2, total_pages: 1}
    end
  end
end