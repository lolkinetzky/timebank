defmodule TimebankWeb.MytimeController do
  use TimebankWeb, :controller

  def index(conn, _params) do
    requests = Timebank.Trade.list_requests()
    render(conn, "index.html", requests: requests)
  end

  # def index(conn, _params) do
  #   render(conn, "index.html")
  # end

end
