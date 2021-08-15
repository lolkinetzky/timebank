defmodule Timebank.Trade.Chronicon do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chronicon" do

    #field :from, :id
    belongs_to :from, Timebank.Accounts.User
    belongs_to :to, Timebank.Accounts.User
    field :time, :float

    timestamps()
  end

  @doc false
  def changeset(chronicon, attrs) do
    chronicon
    |> cast(attrs, [:from, :to, :time])
    |> validate_required([:from, :to, :time])
  end
end
