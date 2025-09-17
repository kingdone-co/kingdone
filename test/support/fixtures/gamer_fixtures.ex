defmodule Kingdone.GamerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Kingdone.Gamer` context.
  """

  alias Kingdone.Gamer

  @doc """
  Generate a profile.
  """
  def profile_fixture(attrs \\ %{}) do
    name = attrs[:name] || "Gamer #{System.unique_integer([:positive])}"

    Gamer.set_name(name)
  end
end
