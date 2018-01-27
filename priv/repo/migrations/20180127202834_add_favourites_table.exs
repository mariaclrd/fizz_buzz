defmodule FizzBuzz.Repo.Migrations.AddFavouritesTable do
  use Ecto.Migration

  def change do
    create table("favourites") do
      add :number, :integer

      timestamps()
    end
  end
end
