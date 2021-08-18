defmodule Timebank.Skills do
  import Ecto.Query, warn: false
  alias Timebank.Repo

  alias Timebank.Skills.{Tag, Timelord}
  alias Timebank.Accounts.User

  def list_tags do
    Tag
    |> Repo.all()
    |> Repo.preload(timelord: [user: :credential])
  end

  def get_tag!(id) do
    Tag
    |> Repo.get!(id)
    |> Repo.preload(timelord: [user: :credential])
  end

  def create_tag(%Timelord{} = timelord, attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Ecto.Changeset.put_change(:timelord_id, timelord.id)
    |> Repo.insert()
  end

  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
  end

  def change_tag(%Tag{} = tag, attrs \\ %{}) do
    Tag.changeset(tag, attrs)
  end

  alias Timebank.Skills.Timelord

  def list_timelords do
    Repo.all(Timelord)
  end

  def get_timelord!(id) do
    Timelord
    |> Repo.get!(id)
    |> Repo.preload(user: :credential)
  end

  def create_timelord(attrs \\ %{}) do
    %Timelord{}
    |> Timelord.changeset(attrs)
    |> Repo.insert()
  end

  def update_timelord(%Timelord{} = timelord, attrs) do
    timelord
    |> Timelord.changeset(attrs)
    |> Repo.update()
  end

  def delete_timelord(%Timelord{} = timelord) do
    Repo.delete(timelord)
  end

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
