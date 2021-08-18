defmodule Timebank.Accounts do
  import Ecto.Query, warn: false
  alias Timebank.Repo

  alias Timebank.Accounts.{User, Credential}

  def authenticate_by_email_password(email, _password) do
    query =
      from u in User,
        inner_join: c in assoc(u, :credential),
        where: c.email == ^email

    case Repo.one(query) do
      %User{} = user -> {:ok, user}
      nil -> {:error, :unauthorized}
    end
  end

  def list_users do
    User
    |> Repo.all()
    |> Repo.preload(:credential)
  end

  def get_user!(id) do
    User
    |> Repo.get!(id)
    |> Repo.preload(:credential)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Ecto.Changeset.cast_assoc(:credential, with: &Credential.changeset/2)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Ecto.Changeset.cast_assoc(:credential, with: &Credential.changeset/2)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  alias Timebank.Accounts.Credential

  def list_credentials do
    Repo.all(Credential)
  end

  def get_credential!(id), do: Repo.get!(Credential, id)

  def create_credential(attrs \\ %{}) do
    %Credential{}
    |> Credential.changeset(attrs)
    |> Repo.insert()
  end

  def update_credential(%Credential{} = credential, attrs) do
    credential
    |> Credential.changeset(attrs)
    |> Repo.update()
  end

  def delete_credential(%Credential{} = credential) do
    Repo.delete(credential)
  end

  def change_credential(%Credential{} = credential, attrs \\ %{}) do
    Credential.changeset(credential, attrs)
  end
end
