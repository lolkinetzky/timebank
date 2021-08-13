defmodule Timebank.Repo.Migrations.AddTimelordIdToSkillTags do
  use Ecto.Migration

  def change do
    alter table(:tags) do
      add :timelord_id, references(:timelords, on_delete: :delete_all),
                      null: false
    end

    create index(:tags, [:timelord_id])
  end
end
