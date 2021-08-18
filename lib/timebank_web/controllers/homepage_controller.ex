defmodule TimebankWeb.HomepageController do
  use TimebankWeb, :controller

  alias Timebank.Accounts

  def index(conn, _params) do
    render(conn, "index.html",
    join_tictaak: Accounts.create_user())
  end

  def landing(conn, _params) do
    render(conn, "landing.html")
  end
end
