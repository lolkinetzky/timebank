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

  describe "chronicon" do
    alias Timebank.Trade.Chronicon

    @valid_attrs %{time: 120.5}
    @update_attrs %{time: 456.7}
    @invalid_attrs %{time: nil}

    def chronicon_fixture(attrs \\ %{}) do
      {:ok, chronicon} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Trade.create_chronicon()

      chronicon
    end

    test "list_chronicon/0 returns all chronicon" do
      chronicon = chronicon_fixture()
      assert Trade.list_chronicon() == [chronicon]
    end

    test "get_chronicon!/1 returns the chronicon with given id" do
      chronicon = chronicon_fixture()
      assert Trade.get_chronicon!(chronicon.id) == chronicon
    end

    test "create_chronicon/1 with valid data creates a chronicon" do
      assert {:ok, %Chronicon{} = chronicon} = Trade.create_chronicon(@valid_attrs)
      assert chronicon.time == 120.5
    end

    test "create_chronicon/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trade.create_chronicon(@invalid_attrs)
    end

    test "update_chronicon/2 with valid data updates the chronicon" do
      chronicon = chronicon_fixture()
      assert {:ok, %Chronicon{} = chronicon} = Trade.update_chronicon(chronicon, @update_attrs)
      assert chronicon.time == 456.7
    end

    test "update_chronicon/2 with invalid data returns error changeset" do
      chronicon = chronicon_fixture()
      assert {:error, %Ecto.Changeset{}} = Trade.update_chronicon(chronicon, @invalid_attrs)
      assert chronicon == Trade.get_chronicon!(chronicon.id)
    end

    test "delete_chronicon/1 deletes the chronicon" do
      chronicon = chronicon_fixture()
      assert {:ok, %Chronicon{}} = Trade.delete_chronicon(chronicon)
      assert_raise Ecto.NoResultsError, fn -> Trade.get_chronicon!(chronicon.id) end
    end

    test "change_chronicon/1 returns a chronicon changeset" do
      chronicon = chronicon_fixture()
      assert %Ecto.Changeset{} = Trade.change_chronicon(chronicon)
    end
  end

  describe "batch" do
    alias Timebank.Trade.Batch

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def batch_fixture(attrs \\ %{}) do
      {:ok, batch} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Trade.create_batch()

      batch
    end

    test "list_batch/0 returns all batch" do
      batch = batch_fixture()
      assert Trade.list_batch() == [batch]
    end

    test "get_batch!/1 returns the batch with given id" do
      batch = batch_fixture()
      assert Trade.get_batch!(batch.id) == batch
    end

    test "create_batch/1 with valid data creates a batch" do
      assert {:ok, %Batch{} = batch} = Trade.create_batch(@valid_attrs)
    end

    test "create_batch/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trade.create_batch(@invalid_attrs)
    end

    test "update_batch/2 with valid data updates the batch" do
      batch = batch_fixture()
      assert {:ok, %Batch{} = batch} = Trade.update_batch(batch, @update_attrs)
    end

    test "update_batch/2 with invalid data returns error changeset" do
      batch = batch_fixture()
      assert {:error, %Ecto.Changeset{}} = Trade.update_batch(batch, @invalid_attrs)
      assert batch == Trade.get_batch!(batch.id)
    end

    test "delete_batch/1 deletes the batch" do
      batch = batch_fixture()
      assert {:ok, %Batch{}} = Trade.delete_batch(batch)
      assert_raise Ecto.NoResultsError, fn -> Trade.get_batch!(batch.id) end
    end

    test "change_batch/1 returns a batch changeset" do
      batch = batch_fixture()
      assert %Ecto.Changeset{} = Trade.change_batch(batch)
    end
  end
end
