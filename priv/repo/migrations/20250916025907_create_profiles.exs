defmodule Kingdone.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :name, :string
      add :title, :string
      add :reclaimed_buildings, {:array, :string}

      timestamps(type: :utc_datetime)
    end
  end
end
