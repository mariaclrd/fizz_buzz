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

      assert body["entries"] == [%{ "number" => 1}]
    end

    test "returns the expected body with the pagination", %{conn: conn} do
      conn = get conn, "api/numbers"

      body = json_response(conn, 200)

      assert body["pagination"] == %{
               "total_pages" => 1,
               "current_page" => 1,
               "total_entries" => 1
             }
    end
  end
end