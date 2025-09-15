defmodule Kingdone.Repo do
  use Ecto.Repo,
    otp_app: :kingdone,
    adapter: Ecto.Adapters.SQLite3
end
