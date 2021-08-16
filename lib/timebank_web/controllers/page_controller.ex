defmodule TimebankWeb.PageController do
  use TimebankWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def landing(conn, _params) do
    render(conn, "landing.html")
  end
end
