defmodule FizzBuzzWeb.NumbersControllerTest do
  use FizzBuzzWeb.ConnCase

  describe "GET /api/numbers" do
    test "GET /api/numbers", %{conn: conn} do
      resp = get conn, "/api/numbers"
      assert resp.status == 200
    end
  end
end