defmodule FizzBuzzWeb.NumberControllerTest do
  use FizzBuzzWeb.ConnCase
  alias FizzBuzz.Favourites.Favourite

  describe "GET /api/numbers" do
    def do_request(params \\ %{}) do
      conn = build_conn()

      get conn, "api/numbers", Map.merge(%{"format" => "json"}, params)
    end

    test "returns 200" do
      resp = do_request()
      assert resp.status == 200
    end

    test "returns the expected body with the entries" do
      conn = do_request()

      body = json_response(conn, 200)

      assert (body["entries"] |> List.first) == %{"number" => 1, "fizz_buzz_value" => 1, "favourite" => false}
      assert (body["entries"] |> length) == 100
    end

    test "returns the favourite value for each element" do
      Favourite.create(%{number: 1})
      conn = do_request()

      body = json_response(conn, 200)

      assert (body["entries"] |> List.first) == %{"number" => 1, "fizz_buzz_value" => 1, "favourite" => true}
      assert (body["entries"] |> length) == 100
    end

    test "returns the expected body with the pagination" do
      conn = do_request()

      body = json_response(conn, 200)

      assert body["pagination"] == %{
               "total_pages" => 1_000_000_000,
               "current_page" => 1,
               "total_entries" => 100_000_000_000
             }
    end

    test "returns the specified number when passing pagination values" do
      conn = do_request(%{current_page: 2, page_size: 200})

      body = json_response(conn, 200)

      assert (body["entries"] |> List.first) == %{"number" => 201, "fizz_buzz_value" => "Fizz", "favourite" => false}
      assert body["pagination"] == %{
               "total_pages" => 500_000_000,
               "current_page" => 2,
               "total_entries" => 100_000_000_000
             }
    end

    test "works also when passing strings" do
      conn = do_request(%{current_page: "2", page_size: "200"})

      body = json_response(conn, 200)

      assert (body["entries"] |> List.first) == %{"number" => 201, "fizz_buzz_value" => "Fizz", "favourite" => false}
      assert body["pagination"] == %{
               "total_pages" => 500_000_000,
               "current_page" => 2,
               "total_entries" => 100_000_000_000
             }
    end
  end

  describe "GET /" do
    def do_html_request(params \\ %{}) do
      conn = build_conn()

      get conn, "/", Map.merge(%{"format" => "html"}, params)
    end

    test "returns 200" do
      conn = do_html_request()

      assert conn.status == 200
    end

    test "returns the header of the number list" do
      conn = do_html_request()
      assert html_response(conn, 200) =~ "List of FizzBuzz Numbers"
    end

    test "shows the list of numbers" do
      conn = do_html_request()
      assert html_response(conn, 200) =~ "<b> Number: </b> 1\n        <b> FizzBuzz: </b> 1\n"
      assert html_response(conn, 200) =~ "<b> Number: </b> 100\n        <b> FizzBuzz: </b> Buzz\n"
    end

    test "allows to specify a page" do
      conn = do_html_request(%{current_page: 2, page_size: 200})
      assert html_response(conn, 200) =~ "<b> Number: </b> 201\n        <b> FizzBuzz: </b> Fizz\n"
    end

    test "works also when passing strings as values" do
      conn = do_html_request(%{current_page: "2", page_size: "200"})
      assert html_response(conn, 200) =~ "<b> Number: </b> 201\n        <b> FizzBuzz: </b> Fizz\n"
    end

    test "it has a link to the nex page" do
      conn = do_html_request()
      assert html_response(conn, 200) =~ "Next Page"
      assert html_response(conn, 200) =~ "?current_page=2"
    end

    test "it has a link to the next page if the user is not in the first page" do
      conn = do_html_request(%{current_page: 2})
      assert html_response(conn, 200) =~ "Previous Page"
      assert html_response(conn, 200) =~ "?current_page=1"
    end

    test "has an input field to change the page size" do
      conn = do_html_request()
      assert html_response(conn, 200) =~ "Page size"
    end
  end
end