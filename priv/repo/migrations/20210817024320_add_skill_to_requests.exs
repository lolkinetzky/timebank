defmodule Timebank.Repo.Migrations.AddSkillToRequests do
  use Ecto.Migration

  def change do
    alter table(:requests) do
      add :skill_id, references(:tags, on_delete: :nothing)
    end

  end
end
