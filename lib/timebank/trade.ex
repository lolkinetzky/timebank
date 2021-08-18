defmodule Timebank.Trade do
  import Ecto.Query, warn: false
  alias Timebank.Repo

  alias Timebank.Trade.Request
  alias Timebank.Skills.Timelord
  alias Timebank.Accounts
  alias Timebank.Accounts.User

  def inc_request_views(%Request{} = request) do
    {1, [%Request{views: views}]} =
      from(i in Request, where: i.id == ^request.id, select: [:views])
      |> Repo.update_all(inc: [views: 1])

    put_in(request.views, views)
  end

  def list_requests do
    Request
    |> Repo.all()
    |> Repo.preload(timelord: [user: :credential])
  end

  def list_my_requests(user) do
    user = User
          |> Repo.get!(user.id)
          |> Repo.preload(timelord: [:requests])
    user.timelord.requests
  end

  def list_my_work(user) do
    user = User
          |> Repo.get!(user.id)
          |> Repo.preload(:requests)
    user.requests
  end

  def get_request!(id) do
    Request
    |> Repo.get!(id)
    |> Repo.preload(timelord: [user: :credential])
  end

  def get_timelord!(id) do
    Timelord
    |> Repo.get!(id)
    |> Repo.preload(user: :credential)
  end

  def create_request(%Timelord{} = timelord, attrs \\ %{}) do
    %Request{}
    |> Request.changeset(attrs)
    |> Ecto.Changeset.put_change(:timelord_id, timelord.id)
    |> Repo.insert()
  end

  def ensure_timelord_exists(%Accounts.User{} = user) do
    %Timelord{user_id: user.id}
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.unique_constraint(:user_id)
    |> Repo.insert()
    |> handle_existing_timelord()
  end

  defp handle_existing_timelord({:ok, timelord}), do: timelord

  defp handle_existing_timelord({:error, changeset}) do
    Repo.get_by!(Timelord, user_id: changeset.data.user_id)
  end

  def update_request(%Request{} = request, attrs) do
    request
    |> Request.changeset(attrs)
    |> Repo.update()
  end

  def delete_request(%Request{} = request) do
    Repo.delete(request)
  end

  def change_request(%Request{} = request, attrs \\ %{}) do
    Request.changeset(request, attrs)
  end

  alias Timebank.Trade.Chronicon

  def list_chronicon do
    Repo.all(Chronicon)
  end

  def get_chronicon!(id), do: Repo.get!(Chronicon, id)

  def create_chronicon(attrs \\ %{}) do
    %Chronicon{}
    |> Chronicon.changeset(attrs)
    |> Repo.insert()
  end

  def update_chronicon(%Chronicon{} = chronicon, attrs) do
    chronicon
    |> Chronicon.changeset(attrs)
    |> Repo.update()
  end

  def delete_chronicon(%Chronicon{} = chronicon) do
    Repo.delete(chronicon)
  end

  def change_chronicon(%Chronicon{} = chronicon, attrs \\ %{}) do
    Chronicon.changeset(chronicon, attrs)
  end
end
