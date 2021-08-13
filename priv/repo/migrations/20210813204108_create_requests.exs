defmodule Timebank.Repo.Migrations.CreateRequests do
  use Ecto.Migration

  def change do
    create table(:requests) do
      add :title, :text
      add :body, :text
      add :amount_offered, :float
      add :views, :integer, default: 0

      timestamps()
    end

  end
end
