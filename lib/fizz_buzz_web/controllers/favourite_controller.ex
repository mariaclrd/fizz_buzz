defmodule FizzBuzzWeb.FavouriteController do
  use FizzBuzzWeb, :controller
  alias FizzBuzz.Favourites.Favourite
  alias FizzBuzz.Repo

  def create(conn, params) do
    with {:ok, changeset} <- valid_changes(%{number: params["number"]}),
         {:ok, favourite} <- Repo.insert(changeset) do
      success_create_response(conn, favourite)
    else
      {:error, _} -> error_response(conn)
    end
  end

  defp error_response(conn) do
    conn
    |> send_resp(422, "unprocessable entity")
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

  defp valid_changes(attrs) do
    changeset = Favourite.changeset(%Favourite{}, attrs)
    if changeset.valid? do
      {:ok, Ecto.Changeset.apply_changes(changeset)}
    else
      {:error, :invalid}
    end
  end
end
