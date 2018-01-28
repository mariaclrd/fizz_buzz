defmodule FizzBuzz.Favourites.Favourite do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias FizzBuzz.Favourites.Favourite
  alias FizzBuzz.Repo

  schema "favourites" do
    field :number, :integer

    timestamps()
  end

  @doc false
  def changeset(%Favourite{} = favourite, attrs) do
    favourite
    |> cast(attrs, [:number])
    |> validate_required([:number])
  end

  def create(attrs) do
    with {:ok, changeset} <- valid_changes(attrs) do
      Repo.insert(changeset)
    end
  end

  def find_by_id(id) do
    query = from f in Favourite,
                 select: f,
                 where: f.id == ^id

    case Repo.one(query) do
      nil -> {:error, :not_found}
      resource -> {:ok, resource}
    end
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