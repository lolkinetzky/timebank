defmodule Timebank.Trade do
  @moduledoc """
  The Trade context.
  """

  import Ecto.Query, warn: false
  alias Timebank.Repo

  alias Timebank.Trade.Request
  alias Timebank.Skills.Timelord
  alias Timebank.Accounts
  alias Timebank.Accounts.User
  # alias Timebank.Trade.{Request, Timelord}
  # just throwing everything at it to see which one sticks?? lol

  def inc_request_views(%Request{} = request) do
    {1, [%Request{views: views}]} =
      from(i in Request, where: i.id == ^request.id, select: [:views])
      |> Repo.update_all(inc: [views: 1])

    put_in(request.views, views)
  end

  @doc """
  Returns the list of requests.

  ## Examples

      iex> list_requests()
      [%Request{}, ...]

  """
  # def list_requests do
  #   Request
  #   |> Repo.all()
  #   |> Repo.preload(timelord: [user: :credential])
  # end
  # def ecto_query_authored_request() do
  #   query =
  #     from skill_request in Request,
  #       inner_join: user in assoc(skill_request, :user),
  #       where: user.id == ^user_id

  #   case Repo.all(query) do
  #     %User{} = user -> {:ok, user}
  #     nil -> {:error, "Nothing here. Try authoring a skill request."}
  #   end
  # end
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

  # def list_requests(opts \\ []) do
  #   Request
  #   |> TokenOperator.maybe(opts, :filter,
  #     authored_requests: &authored_requests/2,
  #     user_donee: &user_donee/2
  #   )
  #   |> Repo.all()
  #   #|> Repo.preload(timelord: [user: :credential])
  # end

  # defp authored_requests(query, %{filter: %{user_id: user_id}}) do
  #   timelord = Repo.get Timelord, where: [user_id: user_id]
  #   #|> Repo.all Ecto.assoc(timelord, :requests)
  #   from query, where: [timelord_id: ^timelord.id]
  # end

  # defp user_donee(query, %{filter: %{user_id: donee_id}}) do
  #   from query, where: [donee_id: ^donee_id]
  #   #|> Repo.all()
  # end

  @doc """
  Gets a single request.

  Raises `Ecto.NoResultsError` if the Request does not exist.

  ## Examples

      iex> get_request!(123)
      %Request{}

      iex> get_request!(456)
      ** (Ecto.NoResultsError)

  """
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

  @doc """
  Creates a request.

  ## Examples

      iex> create_request(%{field: value})
      {:ok, %Request{}}

      iex> create_request(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  # expanded struct b/c errors. will see if causes more issues.
  def create_request(%Timelord{} = timelord, attrs \\ %{}) do
    %Request{}
    |> Request.changeset(attrs)
    |> Ecto.Changeset.put_change(:timelord_id, timelord.id)
    |> Repo.insert()
  end

  def ensure_timelord_exists(%Accounts.User{} = user) do
    # expanded struct b/c errors. will see if causes more issues.
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

  @doc """
  Updates a request.

  ## Examples

      iex> update_request(request, %{field: new_value})
      {:ok, %Request{}}

      iex> update_request(request, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_request(%Request{} = request, attrs) do
    request
    |> Request.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a request.

  ## Examples

      iex> delete_request(request)
      {:ok, %Request{}}

      iex> delete_request(request)
      {:error, %Ecto.Changeset{}}

  """
  def delete_request(%Request{} = request) do
    Repo.delete(request)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking request changes.

  ## Examples

      iex> change_request(request)
      %Ecto.Changeset{data: %Request{}}

  """
  def change_request(%Request{} = request, attrs \\ %{}) do
    Request.changeset(request, attrs)
  end

  alias Timebank.Trade.Chronicon

  @doc """
  Returns the list of chronicon.

  ## Examples

      iex> list_chronicon()
      [%Chronicon{}, ...]

  """
  def list_chronicon do
    Repo.all(Chronicon)
  end

  @doc """
  Gets a single chronicon.

  Raises `Ecto.NoResultsError` if the Chronicon does not exist.

  ## Examples

      iex> get_chronicon!(123)
      %Chronicon{}

      iex> get_chronicon!(456)
      ** (Ecto.NoResultsError)

  """
  def get_chronicon!(id), do: Repo.get!(Chronicon, id)

  @doc """
  Creates a chronicon.

  ## Examples

      iex> create_chronicon(%{field: value})
      {:ok, %Chronicon{}}

      iex> create_chronicon(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_chronicon(attrs \\ %{}) do
    %Chronicon{}
    |> Chronicon.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a chronicon.

  ## Examples

      iex> update_chronicon(chronicon, %{field: new_value})
      {:ok, %Chronicon{}}

      iex> update_chronicon(chronicon, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_chronicon(%Chronicon{} = chronicon, attrs) do
    chronicon
    |> Chronicon.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a chronicon.

  ## Examples

      iex> delete_chronicon(chronicon)
      {:ok, %Chronicon{}}

      iex> delete_chronicon(chronicon)
      {:error, %Ecto.Changeset{}}

  """
  def delete_chronicon(%Chronicon{} = chronicon) do
    Repo.delete(chronicon)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking chronicon changes.

  ## Examples

      iex> change_chronicon(chronicon)
      %Ecto.Changeset{data: %Chronicon{}}

  """
  def change_chronicon(%Chronicon{} = chronicon, attrs \\ %{}) do
    Chronicon.changeset(chronicon, attrs)
  end
end
