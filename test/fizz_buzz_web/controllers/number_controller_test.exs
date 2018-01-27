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

      assert (body["entries"] |> List.first) == %{ "number" => 1}
      assert (body["entries"] |> length) == 100
    end

    test "returns the expected body with the pagination", %{conn: conn} do
      conn = get conn, "api/numbers"

      body = json_response(conn, 200)

      assert body["pagination"] == %{
               "total_pages" => 10000000000,
               "current_page" => 1,
               "total_entries" => 100000000000
             }
    end
  end
end