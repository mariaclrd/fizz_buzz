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
    with {:ok, changeset} <- valid_changes(attrs),
         {:error, :not_found} <- find_by_number(attrs[:number]) do
      Repo.insert(changeset)
    end
  end

  def for_numbers(numbers) do
    {:ok, favourites} = numbers
      |> Enum.map(&(&1[:number]))
      |> Favourite.find_for_numbers

    numbers
      |> Enum.map(&(Map.put(&1, :favourite, Enum.any?(favourites, fn n -> n.number == &1[:number] end))))
  end

  def find_by_id(id) do
    query = from f in Favourite,
                 select: f,
                 where: f.id == ^id

    find(query)
  end

  def find_by_number(number) do
    query = from f in Favourite,
                 select: f,
                 where: f.number == ^number
    find(query)
  end

  def find_for_numbers(number) do
    query = from f in Favourite,
                 select: f,
                 where: f.number in ^number
    {:ok, Repo.all(query) }
  end

  defp find(query) do
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