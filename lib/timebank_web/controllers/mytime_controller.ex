defmodule TimebankWeb.MytimeController do
  use TimebankWeb, :controller

  alias Timebank.Trade

  def index(conn, _params) do
    current_user = conn.assigns.current_user
    render(conn, "index.html",
      my_requests: Trade.list_my_requests(current_user),
      my_work: Trade.list_my_work(current_user))
  end
end
