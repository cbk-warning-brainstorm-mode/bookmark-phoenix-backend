defmodule Bookmark.Tag do
  use Bookmark.Web, :model

  schema "tags" do
    has_many :tag_bookmarks, Bookmark.BookmarkTag
    has_many :bookmarks, through: [:tag_bookmarks, :bookmark]

    field :nome, :string

    timestamps
  end

  @required_fields ~w(nome)
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
