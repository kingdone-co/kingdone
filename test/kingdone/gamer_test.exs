defmodule Kingdone.GamerTest do
  use Kingdone.DataCase

  alias Kingdone.Gamer

  describe "profiles" do
    alias Kingdone.Gamer.Profile

    import Kingdone.GamerFixtures

    test "set_name/1 with valid data creates a profile" do
      name = "some name"
      assert %Profile{} = profile = Gamer.set_name(name)
      assert profile.name == name
    end

    test "set_name/1 with invalid data raises" do
      assert_raise Ecto.InvalidChangesetError, fn ->
        Gamer.set_name(nil)
      end
    end

    test "get_profile/0 returns the profile when it exists" do
      profile = profile_fixture()
      assert Gamer.get_profile() == profile
    end

    test "get_profile/0 returns nil when there is no profile" do
      assert Gamer.get_profile() == nil
    end
  end
end
