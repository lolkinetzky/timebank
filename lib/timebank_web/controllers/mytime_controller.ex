defmodule TimebankWeb.MytimeController do
  use TimebankWeb, :controller

  def index(conn, _params) do
    my_requests = Timebank.Trade.list_user_requests()
    my_work = Timebank.Trade.list_user_donee()
    render(conn, "index.html", requests: my_requests, jobs: my_work)
  end

  # def index(conn, _params) do
  #   render(conn, "index.html")
  # end

end
