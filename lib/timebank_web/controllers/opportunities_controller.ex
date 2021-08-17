defmodule TimebankWeb.OpportunitiesController do
  use TimebankWeb, :controller

  #displays all requests
  def index(conn, _params) do
    render(conn, "index.html")
  end
  
  #displays just current user's opportuntites: requests for skills they have
  def mine(conn, _params) do
    render(conn, "user_opps.html")
  end
end
