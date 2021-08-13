defmodule Timebank.SkillsTest do
  use Timebank.DataCase

  alias Timebank.Skills

  describe "tags" do
    alias Timebank.Skills.Tag

    @valid_attrs %{description: "some description", title: "some title"}
    @update_attrs %{description: "some updated description", title: "some updated title"}
    @invalid_attrs %{description: nil, title: nil}

    def tag_fixture(attrs \\ %{}) do
      {:ok, tag} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Skills.create_tag()

      tag
    end

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Skills.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Skills.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      assert {:ok, %Tag{} = tag} = Skills.create_tag(@valid_attrs)
      assert tag.description == "some description"
      assert tag.title == "some title"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Skills.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{} = tag} = Skills.update_tag(tag, @update_attrs)
      assert tag.description == "some updated description"
      assert tag.title == "some updated title"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Skills.update_tag(tag, @invalid_attrs)
      assert tag == Skills.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Skills.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Skills.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Skills.change_tag(tag)
    end
  end

  describe "timelords" do
    alias Timebank.Skills.Timelord

    @valid_attrs %{bank_role: "some bank_role", catchphrase: "some catchphrase"}
    @update_attrs %{bank_role: "some updated bank_role", catchphrase: "some updated catchphrase"}
    @invalid_attrs %{bank_role: nil, catchphrase: nil}

    def timelord_fixture(attrs \\ %{}) do
      {:ok, timelord} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Skills.create_timelord()

      timelord
    end

    test "list_timelords/0 returns all timelords" do
      timelord = timelord_fixture()
      assert Skills.list_timelords() == [timelord]
    end

    test "get_timelord!/1 returns the timelord with given id" do
      timelord = timelord_fixture()
      assert Skills.get_timelord!(timelord.id) == timelord
    end

    test "create_timelord/1 with valid data creates a timelord" do
      assert {:ok, %Timelord{} = timelord} = Skills.create_timelord(@valid_attrs)
      assert timelord.bank_role == "some bank_role"
      assert timelord.catchphrase == "some catchphrase"
    end

    test "create_timelord/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Skills.create_timelord(@invalid_attrs)
    end

    test "update_timelord/2 with valid data updates the timelord" do
      timelord = timelord_fixture()
      assert {:ok, %Timelord{} = timelord} = Skills.update_timelord(timelord, @update_attrs)
      assert timelord.bank_role == "some updated bank_role"
      assert timelord.catchphrase == "some updated catchphrase"
    end

    test "update_timelord/2 with invalid data returns error changeset" do
      timelord = timelord_fixture()
      assert {:error, %Ecto.Changeset{}} = Skills.update_timelord(timelord, @invalid_attrs)
      assert timelord == Skills.get_timelord!(timelord.id)
    end

    test "delete_timelord/1 deletes the timelord" do
      timelord = timelord_fixture()
      assert {:ok, %Timelord{}} = Skills.delete_timelord(timelord)
      assert_raise Ecto.NoResultsError, fn -> Skills.get_timelord!(timelord.id) end
    end

    test "change_timelord/1 returns a timelord changeset" do
      timelord = timelord_fixture()
      assert %Ecto.Changeset{} = Skills.change_timelord(timelord)
    end
  end
end
