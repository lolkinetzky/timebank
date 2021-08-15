defmodule Timebank.Trade.Request do
  use Ecto.Schema
  import Ecto.Changeset

  alias Timebank.Skills.Timelord

  schema "requests" do
    field :amount_offered, :float
    field :body, :string
    field :title, :string
    field :views, :integer
    belongs_to :timelord, Timelord
    belongs_to :donee, Timebank.Accounts.User


    timestamps()
  end

  @doc false
  def changeset(request, attrs) do
    request
    |> cast(attrs, [:title, :body, :amount_offered])
    |> validate_required([:title, :body, :amount_offered])
    #add validating if they have enough money to make request
  end
end
