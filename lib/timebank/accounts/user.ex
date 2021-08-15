defmodule Timebank.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Timebank.Accounts.Credential


  schema "users" do
    field :name, :string
    field :username, :string
    field :balance, :float
    has_one :credential, Credential
    has_many :trades, Timebank.Trade.Chronicon

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username, :balance])
    |> validate_number(:balance, greater_than_or_equal_to: 0)
    |> validate_required([:name, :username, :balance])
    |> unique_constraint(:username)
  end
end
