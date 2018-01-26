defmodule FizzBuzzWeb.NumberControllerTest do
  use FizzBuzzWeb.ConnCase

  describe "GET /api/numbers" do
    test "returns 200", %{conn: conn} do
      resp = get conn, "/api/numbers"
      assert resp.status == 200
    end

    test "returns the expected body", %{conn: conn} do
      conn = get conn, "api/numbers"

      assert json_response(conn, 200) == %{
               "entries" => [%{
                 "number" => 1
               }]
             }
    end
  end
end