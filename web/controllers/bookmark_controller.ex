defmodule Bookmark.BookmarkController do
  use Bookmark.Web, :controller

  alias Bookmark.Bookmark, as: BookmarkModel

  plug :scrub_params, "bookmark" when action in [:create, :update]

  def index(conn, _params) do
    bookmarks = Repo.all(BookmarkModel) |> Repo.preload(:tags)
    render(conn, "index.json", bookmarks: bookmarks)
  end

  def create(conn, %{"bookmark" => bookmark_params}) do
    bookmark_params = Map.update(bookmark_params, "tags", [], &fetch_tags/1)

    changeset = BookmarkModel.changeset(%BookmarkModel{}, bookmark_params)

    case Repo.insert(changeset) do
      {:ok, bookmark} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", bookmark_path(conn, :show, bookmark))
        |> render("show.json", bookmark: Repo.preload(bookmark, :tags))
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Bookmark.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bookmark = Repo.get!(BookmarkModel, id)
    render(conn, "show.json", bookmark: Repo.preload(bookmark, :tags))
  end

  def update(conn, %{"id" => id, "bookmark" => bookmark_params}) do
    bookmark_params = Map.update(bookmark_params, "tags", [], &fetch_tags/1)

    bookmark = Repo.get!(BookmarkModel, id)
    changeset = BookmarkModel.changeset(bookmark, bookmark_params)

    case Repo.update(changeset) do
      {:ok, bookmark} ->
        render(conn, "show.json", bookmark: Repo.preload(bookmark, :tags))
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Bookmark.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bookmark = Repo.get!(BookmarkModel, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(bookmark)

    send_resp(conn, :no_content, "")
  end

  defp fetch_tags(tags) do
    Enum.map(tags, fn nome ->
      case Bookmark.Repo.get_by(Bookmark.Tag, nome: nome) do
         nil -> %Bookmark.Tag{nome: nome}
         tag -> tag
      end
    end)
  end
end
