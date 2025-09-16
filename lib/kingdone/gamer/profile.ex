defmodule Kingdone.Gamer.Profile do
  use Ecto.Schema

  schema "profiles" do
    field :name, :string
    field :title, Ecto.Enum, values: [:lord, :lady, :liege]
    field :reclaimed_buildings, {:array, :string}

    timestamps(type: :utc_datetime)
  end
end
