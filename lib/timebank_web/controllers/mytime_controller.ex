defmodule TimebankWeb.MytimeController do
  use TimebankWeb, :controller
  #alias Timebank.CurrentUser doesn't seem to work as intended, no time to debug hope it's ok the files hang out

  alias Timebank.Trade


  def index(conn, _params) do
    current_user = conn.assigns.current_user
    render(conn, "index.html",
      my_requests: Trade.list_my_requests(current_user),
      my_work: Trade.list_my_work(current_user))

    # #%user{id: user_id} = Timebank.Accounts.get_user!(current_user)
    # #need to basically write more filter by stuff in skills to be able to get the next part
    # #timelord = Timebank.Skills.get_timelord!(user.id)
    # my_requests = Timebank.Trade.list_requests(filter: [:authored_requests, current_user])
    # my_work = Timebank.Trade.list_requests(filter: [:user_donee, current_user])
    # render(conn, "index.html", requests: my_requests, jobs: my_work)
  end

  # def index(conn, _params) do
  #   render(conn, "index.html")
  # end

end
