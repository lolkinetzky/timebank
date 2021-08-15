defmodule Timebank.Repo.Migrations.AddDoneeToRequests do
  use Ecto.Migration

  def change do
    alter table(:requests) do
      add :donee_id, references(:users, on_delete: :nothing)
    end

  end
end
