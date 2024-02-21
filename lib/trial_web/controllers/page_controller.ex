defmodule TrialWeb.PageController do
  use TrialWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end
  def users(conn, _params) do
    users = [
      %{id: 1, name: "lenah", email: "lenahdevy@gmail.com"},
      %{id: 2, name: "david", email: "lenahdavid@gmail.com"}
    ]
    # The home page is often custom made,
    # so skip the default app layout.
    json(conn, %{users: users})
  end
end
