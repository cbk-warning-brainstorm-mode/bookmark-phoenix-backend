defmodule Bookmark.BookmarkTag do
  use Bookmark.Web, :model

  schema "bookmark_tags" do
    belongs_to :bookmark, Bookmark.Bookmark
    belongs_to :tag, Bookmark.Tag

    timestamps
  end

  @required_fields ~w(bookmark_id tag_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
