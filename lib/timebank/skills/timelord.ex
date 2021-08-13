defmodule Timebank.Skills.Timelord do
  use Ecto.Schema
  import Ecto.Changeset

  alias Timebank.Skills.Tag

  schema "timelords" do
    field :bank_role, :string
    field :catchphrase, :string
    has_many :tags, Tag
    belongs_to :user, Timebank.Accounts.User


    timestamps()
  end

  @doc false
  def changeset(timelord, attrs) do
    timelord
    |> cast(attrs, [:catchphrase, :bank_role])
    |> validate_required([:catchphrase, :bank_role])
    |> unique_constraint(:user_id)
  end
end
