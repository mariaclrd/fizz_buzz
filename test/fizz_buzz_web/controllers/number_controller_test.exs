defmodule FizzBuzzWeb.NumberControllerTest do
  use FizzBuzzWeb.ConnCase

  describe "GET /api/numbers" do
    test "returns 200", %{conn: conn} do
      resp = get conn, "/api/numbers"
      assert resp.status == 200
    end

    test "returns the expected body with the entries", %{conn: conn} do
      conn = get conn, "api/numbers"

      body = json_response(conn, 200)

      assert (body["entries"] |> List.first) == %{"number" => 1, "fizz_buzz_value" => 1}
      assert (body["entries"] |> length) == 100
    end

    test "returns the expected body with the pagination", %{conn: conn} do
      conn = get conn, "api/numbers"

      body = json_response(conn, 200)

      assert body["pagination"] == %{
               "total_pages" => 1_000_000_000,
               "current_page" => 1,
               "total_entries" => 100_000_000_000
             }
    end

    test "returns the specified page when passing pagination values" do
      conn = build_conn()
      conn = get conn, "api/numbers", %{current_page: 2, page_size: 200}

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