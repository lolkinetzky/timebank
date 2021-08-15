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
    #add a "donee" column default to nil

    timestamps()
  end

  @doc false
  def changeset(request, attrs) do
    request
    |> cast(attrs, [:title, :body, :amount_offered])
    |> validate_required([:title, :body, :amount_offered])
  end
end
