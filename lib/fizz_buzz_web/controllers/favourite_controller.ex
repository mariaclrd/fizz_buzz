defmodule FizzBuzzWeb.FavouriteController do
  use FizzBuzzWeb, :controller
  alias FizzBuzz.Favourites.Favourite

  def create(conn, %{"format" => "json"} = params) do
    with {:ok, favourite} <- Favourite.create(%{number: params["number"]}) do
      success_create_response(conn, favourite)
    else
      {:error, _} -> error_response(conn)
    end
  end

  def create(conn, params) do
    with {:ok, _favourite} <- Favourite.create(%{number: params["number"]}) do
      redirect conn, to: "/"
    else
      {:error, _} -> error_response(conn)
    end
  end

  def show(conn, params) do
    with {:ok, favourite} <- Favourite.find_by_id(params["id"]) do
      render(conn, "show.json", %{favourite: favourite})
    else
      {:error, _} -> not_found_response(conn)
    end
  end

  defp error_response(conn) do
    conn
    |> send_resp(422, "unprocessable entity")
  end

  defp not_found_response(conn) do
    conn
    |> send_resp(404, "not found")
  end

  defp success_create_response(conn, favourite) do
    conn
    |> put_resp_header("location", path(favourite))
    |> put_resp_header("content-type", "application/json")
    |> send_resp(201, "")
  end

  defp path(favourite) do
    "/api/favourites/#{favourite.id}"
  end
end
