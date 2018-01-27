defmodule FizzBuzz.Numbers.PaginationTest do
  use ExUnit.Case
  alias FizzBuzz.Numbers.Pagination
  alias FizzBuzz.Numbers.Number

  describe "entries" do
    test "returns the entries for an specific number and limit" do
      entries =  Number.all |> Pagination.entries(1, 100)
      assert List.first(entries) == 1
      assert List.last(entries) == 100
    end

    test "works also for the second number" do
      entries =  Number.all |> Pagination.entries(2, 100)
      assert List.first(entries) == 101
      assert List.last(entries) == 200
    end
  end

  describe "total_entries" do
    test "returns the total number of entries in the collection" do
      assert Pagination.total_entries(Number.all) == 100_000_000_000
    end

    test "returns the total entries on an array" do
      assert Pagination.total_entries([1,2]) == 2
    end
  end

  describe "total_pages" do
    test "returns the total number of pages for the collection" do
      assert Pagination.total_pages(Number.all) == 1_000_000_000
    end
  end
end