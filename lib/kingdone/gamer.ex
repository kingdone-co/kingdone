defmodule Kingdone.Gamer do
  @moduledoc """
  The Gamer context.
  """

  import Ecto.Query, warn: false
  import Ecto.Changeset
  alias Kingdone.Repo

  alias Kingdone.Gamer.Profile

  @doc """
  Sets the gamer name to a new profile and returns:

  - `{:ok, %Profile{}}` if the name was set successfully
  - `{:error, %Ecto.Changeset{}}` if there was an error setting the name

  ## Examples

      iex> set_name("Alice")
      %Profile{name: "Alice"}

  """
  def set_name(name) do
    %Profile{}
    |> cast(%{name: name}, [:name])
    |> validate_required([:name])
    |> Repo.insert()
  end

  @doc """
  Sets the gamer title on the existing profile and returns the updated profile.

  Raises if anything goes wrong.

  ## Examples

      iex> set_title!(profile, :lord)
      %Profile{title: :lord}

  """
  def set_title!(%Profile{} = profile, title) when is_atom(title) and title != nil do
    profile
    |> change(%{title: title})
    |> validate_required([:title])
    |> Repo.update!()
  end

  @doc """
  Returns the only existing `%Profile{}` or `nil` if none.

  ## Examples

      iex> get_profile()
      nil

      iex> set_name("Bjorn")
      iex> get_profile()
      %Profile{name: "Bjorn"}

  """
  def get_profile do
    Repo.one(Profile)
  end
end
