defmodule FizzBuzz.Favourites.Favourite do
  use Ecto.Schema
  import Ecto.Changeset
  alias FizzBuzz.Favourites.Favourite


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
end