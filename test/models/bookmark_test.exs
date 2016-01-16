defmodule Bookmark.BookmarkTest do
  use Bookmark.ModelCase

  alias Bookmark.Bookmark

  @valid_attrs %{descricao: "some content", link: "some content", nome: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Bookmark.changeset(%Bookmark{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Bookmark.changeset(%Bookmark{}, @invalid_attrs)
    refute changeset.valid?
  end
end
