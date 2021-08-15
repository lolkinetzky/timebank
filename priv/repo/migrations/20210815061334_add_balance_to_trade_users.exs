defmodule Timebank.Repo.Migrations.AddBalanceToTradeUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :balance, :float, default: 0
    end

    create index(:users, [:balance])
  end
end
