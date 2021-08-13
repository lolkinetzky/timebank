defmodule Timebank.Skills do
  @moduledoc """
  The Skills context.
  """

  import Ecto.Query, warn: false
  alias Timebank.Repo

  alias Timebank.Skills.{Tag, Timelord}
  alias Timebank.Accounts.User

  @doc """
  Returns the list of tags.

  ## Examples

      iex> list_tags()
      [%Tag{}, ...]

  """
  def list_tags do
    Tag
    |> Repo.all()
    |> Repo.preload(timelord: [user: :credential])
  end

  @doc """
  Gets a single tag.

  Raises `Ecto.NoResultsError` if the Tag does not exist.

  ## Examples

      iex> get_tag!(123)
      %Tag{}

      iex> get_tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tag!(id) do
    Tag
    |> Repo.get!(id)
    |> Repo.preload(timelord: [user: :credential])
  end

  @doc """
  Creates a tag.

  ## Examples

      iex> create_tag(%{field: value})
      {:ok, %Tag{}}

      iex> create_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tag(%Timelord{} = timelord, attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Ecto.Changeset.put_change(:timelord_id, timelord.id)
    |> Repo.insert()
  end

  @doc """
  Updates a tag.

  ## Examples

      iex> update_tag(tag, %{field: new_value})
      {:ok, %Tag{}}

      iex> update_tag(tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a tag.

  ## Examples

      iex> delete_tag(tag)
      {:ok, %Tag{}}

      iex> delete_tag(tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tag changes.

  ## Examples

      iex> change_tag(tag)
      %Ecto.Changeset{data: %Tag{}}

  """
  def change_tag(%Tag{} = tag, attrs \\ %{}) do
    Tag.changeset(tag, attrs)
  end

  alias Timebank.Skills.Timelord

  @doc """
  Returns the list of timelords.

  ## Examples

      iex> list_timelords()
      [%Timelord{}, ...]

  """
  def list_timelords do
    Repo.all(Timelord)
  end

  @doc """
  Gets a single timelord.

  Raises `Ecto.NoResultsError` if the Timelord does not exist.

  ## Examples

      iex> get_timelord!(123)
      %Timelord{}

      iex> get_timelord!(456)
      ** (Ecto.NoResultsError)

  """
  def get_timelord!(id) do
    Timelord
    |> Repo.get!(id)
    |> Repo.preload(user: :credential)
  end

  @doc """
  Creates a timelord.

  ## Examples

      iex> create_timelord(%{field: value})
      {:ok, %Timelord{}}

      iex> create_timelord(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_timelord(attrs \\ %{}) do
    %Timelord{}
    |> Timelord.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a timelord.

  ## Examples

      iex> update_timelord(timelord, %{field: new_value})
      {:ok, %Timelord{}}

      iex> update_timelord(timelord, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_timelord(%Timelord{} = timelord, attrs) do
    timelord
    |> Timelord.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a timelord.

  ## Examples

      iex> delete_timelord(timelord)
      {:ok, %Timelord{}}

      iex> delete_timelord(timelord)
      {:error, %Ecto.Changeset{}}

  """
  def delete_timelord(%Timelord{} = timelord) do
    Repo.delete(timelord)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking timelord changes.

  ## Examples

      iex> change_timelord(timelord)
      %Ecto.Changeset{data: %Timelord{}}

  """
  def change_timelord(%Timelord{} = timelord, attrs \\ %{}) do
    Timelord.changeset(timelord, attrs)
  end

  def ensure_timelord_exists(%User{} = user) do
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
end
