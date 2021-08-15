defmodule Timebank.Repo.Migrations.AddDoneeToRequests do
  use Ecto.Migration

  def change do
    alter table(:requests) do
      add :donee, references(:users, on_delete: :nothing),
                    null: true
    end

  end
end
