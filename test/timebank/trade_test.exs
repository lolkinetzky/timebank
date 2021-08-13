defmodule Timebank.TradeTest do
  use Timebank.DataCase

  alias Timebank.Trade

  describe "requests" do
    alias Timebank.Trade.Request

    @valid_attrs %{amount_offered: 120.5, body: "some body", title: "some title", views: 42}
    @update_attrs %{amount_offered: 456.7, body: "some updated body", title: "some updated title", views: 43}
    @invalid_attrs %{amount_offered: nil, body: nil, title: nil, views: nil}

    def request_fixture(attrs \\ %{}) do
      {:ok, request} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Trade.create_request()

      request
    end

    test "list_requests/0 returns all requests" do
      request = request_fixture()
      assert Trade.list_requests() == [request]
    end

    test "get_request!/1 returns the request with given id" do
      request = request_fixture()
      assert Trade.get_request!(request.id) == request
    end

    test "create_request/1 with valid data creates a request" do
      assert {:ok, %Request{} = request} = Trade.create_request(@valid_attrs)
      assert request.amount_offered == 120.5
      assert request.body == "some body"
      assert request.title == "some title"
      assert request.views == 42
    end

    test "create_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trade.create_request(@invalid_attrs)
    end

    test "update_request/2 with valid data updates the request" do
      request = request_fixture()
      assert {:ok, %Request{} = request} = Trade.update_request(request, @update_attrs)
      assert request.amount_offered == 456.7
      assert request.body == "some updated body"
      assert request.title == "some updated title"
      assert request.views == 43
    end

    test "update_request/2 with invalid data returns error changeset" do
      request = request_fixture()
      assert {:error, %Ecto.Changeset{}} = Trade.update_request(request, @invalid_attrs)
      assert request == Trade.get_request!(request.id)
    end

    test "delete_request/1 deletes the request" do
      request = request_fixture()
      assert {:ok, %Request{}} = Trade.delete_request(request)
      assert_raise Ecto.NoResultsError, fn -> Trade.get_request!(request.id) end
    end

    test "change_request/1 returns a request changeset" do
      request = request_fixture()
      assert %Ecto.Changeset{} = Trade.change_request(request)
    end
  end
end
