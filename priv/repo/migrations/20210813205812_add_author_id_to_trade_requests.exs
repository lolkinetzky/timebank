defmodule Timebank.Repo.Migrations.AddAuthorIdToTradeRequests do
  use Ecto.Migration

  alias Timebank.Skills.Timelord
  
  def change do
    alter table(:requests) do
      add :timelord_id, references(:timelords, on_delete: :delete_all),
                      null: false
    end

    create index(:requests, [:timelord_id])
  end
end
