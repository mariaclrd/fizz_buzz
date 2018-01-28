defmodule FizzBuzzWeb.FavouriteControllerTest do
  use FizzBuzzWeb.ConnCase
  use FizzBuzz.DataCase
  alias FizzBuzz.Favourites.Favourite

  describe "POST /api/favourites" do
    def do_request(params \\ %{}) do
      conn = build_conn()

      post conn, "api/favourites", Map.merge(%{"format" => "json"}, params)
    end

    test "returns 201" do
      resp = do_request(%{number: 1})
      assert resp.status == 201
    end

    test "returns an empty body" do
      conn = do_request(%{number: 1})
      body = response(conn, 201)
      assert body == ""
    end

    test "it stores the favourite number" do
      do_request(%{number: 1})
      assert length(Repo.all(Favourite)) == 1
    end

    test "returns the location header" do
      resp = do_request(%{number: 2})

      location_headers = Enum.filter resp.resp_headers, fn(elm) ->
        {key, _} = elm
        key == "location"
      end

      [{"location", val}] = location_headers

      favourite_id = Repo.one(Favourite).id
      assert val == "/api/favourites/#{favourite_id}"
    end

    test "returns an error response if the changes are not valid" do
      resp = do_request(%{number: "blah"})
      assert resp.status == 422
    end
  end

  describe "GET /api/favourites/:id" do
    def do_get_request(params \\ %{}) do
      conn = build_conn()

      get conn, "api/favourites/#{params[:id]}", Map.merge(%{"format" => "json"}, params)
    end

    test "returns 200" do
      {:ok, favourite} = Repo.insert(%Favourite{number: 12})

      resp = do_get_request( %{id: favourite.id} )
      assert resp.status == 200
    end

    test "returns the expected body" do
      {:ok, favourite} = Repo.insert(%Favourite{number: 12})

      conn = do_get_request( %{id: favourite.id} )
      body = json_response(conn, 200)

      assert body == %{
               "id" =>  favourite.id,
               "number" => favourite.number
             }
    end

    test "returns 404 if record not found" do
      resp = do_get_request( %{id: 100} )
      assert resp.status == 404
    end
  end
end