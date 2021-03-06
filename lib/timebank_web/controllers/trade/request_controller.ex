defmodule TimebankWeb.Trade.RequestController do
  use TimebankWeb, :controller

  alias Timebank.Trade
  alias Timebank.Trade.Request

  plug :require_existing_timelord2
  plug :authorize_request when action in [:edit, :update, :delete]

  def index(conn, _params) do
    render(conn, "index.html", requests: Trade.list_requests())
  end

  def new(conn, _params) do
    changeset = Trade.change_request(%Request{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"request" => request_params}) do
    case Trade.create_request(conn.assigns.current_timelord, request_params) do
      {:ok, request} ->
        conn
        |> put_flash(:info, "Request created successfully.")
        |> redirect(to: Routes.trade_request_path(conn, :show, request)) #redirect my to index instead of show?
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    request =
      id
      |> Trade.get_request!()
      |> Trade.inc_request_views()
    render(conn, "show.html", request: request)
  end

  def edit(conn, _) do
    changeset = Trade.change_request(conn.assigns.request)
    render(conn, "edit.html", changeset: changeset)
  end

  def update(conn, %{"request" => request_params}) do
    case Trade.update_request(conn.assigns.request, request_params) do
      {:ok, request} ->
        conn
        |> put_flash(:info, "Request updated successfully.")
        |> redirect(to: Routes.trade_request_path(conn, :show, request))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  def delete(conn, _) do
    {:ok, _request} = Trade.delete_request(conn.assigns.request)

    conn
    |> put_flash(:info, "Request deleted successfully.")
    |> redirect(to: Routes.trade_request_path(conn, :index))
  end

  def initiate_trade(conn, %{"donee_id" => _id}) do
    request = %Request{}
    # TODO: assign donee to request
    Timebank.Trade.Batch.trade(request)

    conn
    |> put_flash(:info, "Trade initiated: time has been transferred.")
    |> redirect(to: Routes.trade_request_path(conn, :show, request))
  end

  defp require_existing_timelord2(conn, _) do
    timelord = Timebank.Trade.ensure_timelord_exists(conn.assigns.current_user)
    assign(conn, :current_timelord, timelord)
  end

  defp authorize_request(conn, _) do
    request = Trade.get_request!(conn.params["id"])

    if conn.assigns.current_timelord.id == request.timelord_id do
      assign(conn, :request, request)
    else
      conn
      |> put_flash(:error, "You can't modify that tho")
      |> redirect(to: Routes.trade_request_path(conn, :index))
      |> halt()
    end
  end
end
