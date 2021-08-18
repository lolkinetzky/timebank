defmodule TimebankWeb.Skills.TagController do
  use TimebankWeb, :controller

  alias Timebank.Skills
  alias Timebank.Skills.Tag

  plug :require_existing_timelord
  plug :authorize_tag when action in [:edit, :update, :delete]

  defp require_existing_timelord(conn, _) do
    timelord = Skills.ensure_timelord_exists(conn.assigns.current_user)
    assign(conn, :current_timelord, timelord)
  end

  defp authorize_tag(conn, _) do
    tag = Skills.get_tag!(conn.params["id"])

    if conn.assigns.current_timelord.id == tag.timelord_id do
      assign(conn, :tag, tag)
    else
      conn
      |> put_flash(:error, "You can't bro")
      |> redirect(to: Routes.skills_tag_path(conn, :index))
      |> halt()
    end
  end

  def index(conn, _params) do
    tags = Skills.list_tags()
    render(conn, "index.html", tags: tags)
  end

  def new(conn, _params) do
    changeset = Skills.change_tag(%Tag{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tag" => tag_params}) do
    case Skills.create_tag(conn.assigns.current_timelord, tag_params) do
      {:ok, tag} ->
        conn
        |> put_flash(:info, "Tag created successfully.")
        |> redirect(to: Routes.skills_tag_path(conn, :show, tag))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tag = Skills.get_tag!(id)
    render(conn, "show.html", tag: tag)
  end

  def edit(conn, _) do
    changeset = Skills.change_tag(conn.assigns.tag)
    render(conn, "edit.html", changeset: changeset)
  end

  def update(conn, %{"tag" => tag_params}) do
    case Skills.update_tag(conn.assigns.tag, tag_params) do
      {:ok, tag} ->
        conn
        |> put_flash(:info, "Tag updated successfully.")
        |> redirect(to: Routes.skills_tag_path(conn, :show, tag))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  def delete(conn, _) do
    {:ok, _tag} = Skills.delete_tag(conn.assigns.tag)

    conn
    |> put_flash(:info, "Tag deleted successfully.")
    |> redirect(to: Routes.skills_tag_path(conn, :index))
  end
end
