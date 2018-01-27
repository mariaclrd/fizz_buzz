defmodule FizzBuzzWeb.NumberControllerTest do
  use FizzBuzzWeb.ConnCase

  def do_request(params \\ %{}) do
    conn = build_conn()

    get conn, "api/numbers", Map.merge(%{"format" => "json"}, params)
  end

  describe "GET /api/numbers" do
    test "returns 200" do
      resp = do_request()
      assert resp.status == 200
    end

    test "returns the expected body with the entries" do
      conn = do_request()

      body = json_response(conn, 200)

      assert (body["entries"] |> List.first) == %{"number" => 1, "fizz_buzz_value" => 1}
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

    test "returns the specified page when passing pagination values" do
      conn = do_request(%{current_page: 2, page_size: 200})

      body = json_response(conn, 200)

      assert (body["entries"] |> List.first) == %{"number" => 201, "fizz_buzz_value" => "Fizz"}
      assert body["pagination"] == %{
               "total_pages" => 500_000_000,
               "current_page" => 2,
               "total_entries" => 100_000_000_000
             }
    end
  end
end