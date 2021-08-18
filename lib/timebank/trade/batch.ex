defmodule Timebank.Trade.Batch do
  use Ecto.Schema
  alias Ecto.Multi
  import Ecto.Query

  alias Timebank.Repo
  alias Timebank.Accounts.User
  alias Timebank.Trade.Chronicon
  alias Timebank.Trade.Request


  defp retrieve_accounts(acc1_id, acc2_id) do
    fn repo, _ ->
      case from(acc in User, where: acc.id in [^acc1_id, ^acc2_id]) |> repo.all() do
        [acc_a, acc_b] -> {:ok, {acc_a, acc_b}}
        _ -> {:error, :account_not_found}
      end
    end
  end

  defp veri_time_balance(transfer_amount) do
    fn _repo, %{retrieve_accounts_step: {acc_a, acc_b}} ->
      if acc_a.balance < transfer_amount, #was acc b balance
        do: {:error, :balance_too_low},
        else: {:ok, {acc_a, acc_b, transfer_amount}}
    end
  end

  defp subtract_from_a(repo, %{verify_balances_step: {acc_a, _, verified_amount}}) do
    acc_a
    |> User.changeset(%{balance: acc_a.balance - verified_amount})
    |> repo.update()
  end

  defp add_to_b(repo, %{verify_balances_step: {_, acc_b, verified_amount}}) do
    acc_b
    |> User.changeset(%{balance: acc_b.balance + verified_amount})
    |> repo.update()
  end


  def trade(%Request{timelord_id: acc1_id, donee_id: donee_account, amount_offered: amount} = _request) do
    %{user_id: timelord_account} = Timebank.Skills.get_timelord!(acc1_id)
    Multi.new()
    |> Multi.insert(:chronicon, %Chronicon{from_id: timelord_account, to_id: donee_account, time: amount})
    |> Multi.run(:retrieve_accounts_step, retrieve_accounts(timelord_account, donee_account))
    |> Multi.run(:verify_balances_step, veri_time_balance(amount))
    |> Multi.run(:subtract_from_a_step, &subtract_from_a/2)
    |> Multi.run(:add_to_b_step, &add_to_b/2)
    |> Repo.transaction()
  end
end
