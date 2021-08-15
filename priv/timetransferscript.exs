require IEx

case Timebank.Trade.Batch.transfer_time(1, 3, 50) |> Timebank.Repo.transaction() do
  {:ok, results} -> IEx.pry()
  {:error, step, reason, results} -> IEx.pry()
end





#####################
# import Ecto.Query
# alias Timebank.Accounts.User
# alias Timebank.Repo

# transfer = 50

# result =
#   Repo.transaction(fn ->
#     [acc_a, acc_b] = from(acc in User, where: acc.id in [1, 2]) |> Repo.all()

#     if acc_a.balance < transfer, do: Repo.rollback(:balance_too_low)

#     update1 = acc_a |> User.changeset(%{balance: acc_a.balance - 50}) |> Repo.update!()
#     update2 = acc_b |> User.changeset(%{balance: acc_b.balance + 50}) |> Repo.update!()

#     {update1, update2}
#   end)

# # Inspect the result:
# require IEx
# IEx.pry()

#when trying to run this script:
# '''warning: invalid association `trades` in schema Timebank.Accounts.User: associated schema Timebank.Trade.Chronicon does not have field `user_id`
# lib/timebank/accounts/user.ex:1: Timebank.Accounts.User (module)

# [debug] QUERY OK db=0.6ms idle=1.4ms
# begin []
# [debug] QUERY OK source="users" db=6.0ms
# SELECT u0."id", u0."name", u0."username", u0."balance", u0."inserted_at", u0."updated_at" FROM "users" AS u0 WHERE (u0."id" IN (1,2)) []
# [debug] QUERY OK db=0.1ms
# rollback []
# ** (MatchError) no match of right hand side value: [%Timebank.Accounts.User{__meta__: #Ecto.Schema.Metadata<:loaded, "users">, balance: 50.0, credential: #Ecto.Association.NotLoaded<association :credential is not loaded>, id: 1, inserted_at: ~N[2021-08-13 08:29:11], name: "Person Personified", trades: #Ecto.Association.NotLoaded<association :trades is not loaded>, updated_at: ~N[2021-08-13 08:29:11], username: "namedperson"}]
#   priv/timetransferscript.exs:9: anonymous fn/0 in :elixir_compiler_6.__FILE__/1
#   (ecto_sql 3.6.2) lib/ecto/adapters/sql.ex:1017: anonymous fn/3 in Ecto.Adapters.SQL.checkout_or_transaction/4
#   (db_connection 2.4.0) lib/db_connection.ex:1512: DBConnection.run_transaction/4
#   priv/timetransferscript.exs:8: (file)
#   (elixir 1.12.2) lib/code.ex:1261: Code.require_file/2
#   (mix 1.12.2) lib/mix/tasks/run.ex:146: Mix.Tasks.Run.run/5
#   (mix 1.12.2) lib/mix/tasks/run.ex:86: Mix.Tasks.Run.run/1
#   (mix 1.12.2) lib/mix/task.ex:394: anonymous fn/3 in Mix.Task.run_task/3
#   (mix 1.12.2) lib/mix/cli.ex:84: Mix.CLI.run_task/2
#   (elixir 1.12.2) lib/code.ex:1261: Code.require_file/2'''
