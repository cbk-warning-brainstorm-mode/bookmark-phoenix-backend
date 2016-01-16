defmodule Bookmark.BookmarkTagTest do
  use Bookmark.ModelCase

  alias Bookmark.BookmarkTag

  @valid_attrs %{bookmark_id: 42, tag_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = BookmarkTag.changeset(%BookmarkTag{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = BookmarkTag.changeset(%BookmarkTag{}, @invalid_attrs)
    refute changeset.valid?
  end
end
