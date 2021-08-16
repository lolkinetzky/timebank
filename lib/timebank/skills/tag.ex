defmodule Timebank.Skills.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  alias Timebank.Skills.Timelord
  alias Timebank.Trade.Request

  schema "tags" do
    field :description, :string
    field :title, :string
    belongs_to :timelord, Timelord
    has_many :requests, Request

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
