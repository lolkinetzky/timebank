defmodule Timebank.Repo.Migrations.CreateChronicon do
  use Ecto.Migration

  def change do
    create table(:chronicon) do
      add :from, references(:users, on_delete: :nothing)
      add :to, references(:users, on_delete: :nothing)
      add :time, :float

      timestamps()
    end


    create index(:chronicon, [:from])
    create index(:chronicon, [:to])
  end
end
