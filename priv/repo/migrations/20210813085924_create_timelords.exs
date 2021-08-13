defmodule Timebank.Repo.Migrations.CreateTimelords do
  use Ecto.Migration

  def change do
    create table(:timelords) do
      add :catchphrase, :text
      add :bank_role, :string
      add :user_id, references(:users, on_delete: :delete_all),
                    null: false

      timestamps()
    end

    create unique_index(:timelords, [:user_id])
  end
end
