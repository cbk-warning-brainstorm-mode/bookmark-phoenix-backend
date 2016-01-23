defmodule Bookmark.Bookmark do
  use Bookmark.Web, :model

  schema "bookmarks" do
    has_many :bookmark_tags, Bookmark.BookmarkTag, on_replace: :delete
    has_many :tags, through: [:bookmark_tags, :tag]

    field :nome, :string
    field :link, :string
    field :descricao, :string

    timestamps
  end

  @required_fields ~w(nome link)
  @optional_fields ~w(descricao)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:descricao, min: 3)
    |> create_relations
  end

  defp create_relations(changeset) do
    relations =
      changeset.params
      |> Map.get("tags", [])
      |> Enum.map(&create_bookmark_tag(&1, changeset.model))

    put_assoc(changeset, :bookmark_tags, relations)
  end

  defp create_bookmark_tag(tag, %{id: nil}), do: %Bookmark.BookmarkTag{tag_id: tag.id}
  defp create_bookmark_tag(tag, bookmark) do
     %Bookmark.BookmarkTag{tag_id: tag.id, bookmark_id: bookmark.id}
  end
end
