defmodule FizzBuzzWeb.NumberViewTest do
  use FizzBuzzWeb.ConnCase, async: true
  alias FizzBuzz.Favourites.Favourite
  alias FizzBuzzWeb.NumberView

  test "as_json" do
    json_number = NumberView.as_json(1)

    assert json_number == %{  number: 1, fizz_buzz_value: 1}
  end

  describe "entries" do
    test "only returns the entries" do
      entries = NumberView.entries(%{numbers: [1], current_page: 1, page_size: 1})
      assert entries == [%{  number: 1, fizz_buzz_value: 1}]
    end
  end

  describe "pagination" do

    test "returns the expected values" do
      pagination = NumberView.pagination([1])

      assert pagination == %{
               total_entries: 1,
               current_page: 1,
               total_pages: 1
             }
    end

    test "divides the collection based on the number size" do
      pagination = NumberView.pagination([1,2], 1)

      assert pagination == %{
               total_entries: 2,
               current_page: 1,
               total_pages: 2
             }

    end

    test "it allows you to specify the number" do
      pagination = NumberView.pagination([1,2], 1, 2)

      assert pagination == %{
               total_entries: 2,
               current_page: 2,
               total_pages: 2
             }

    end
  end

  describe "render index.json" do

    test "returns the entries" do
      json_numbers = NumberView.render("index.json", %{numbers: [1, 2], current_page: 1, page_size: 5})

      assert json_numbers[:entries] ==  [%{number: 1, fizz_buzz_value: 1}, %{number: 2, fizz_buzz_value: 2}]
    end


    test "renders the pagination" do
      json_numbers = NumberView.render("index.json", %{numbers: [1, 2], current_page: 1, page_size: 5})

      assert json_numbers[:pagination] == %{total_entries: 2, total_pages: 1, current_page: 1}
    end
  end

  describe "is_favourite" do
    test "returns true if the number is stored as favourite on the database" do
      Favourite.create(%{number: 1})
      assert NumberView.is_favourite(1) == true
    end

    test "returns false if the number is not stored as favourite on the database" do
      assert NumberView.is_favourite(1) == false
    end
  end
end