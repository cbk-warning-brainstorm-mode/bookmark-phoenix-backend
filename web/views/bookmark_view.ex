defmodule Bookmark.BookmarkView do
  use Bookmark.Web, :view

  def render("index.json", %{bookmarks: bookmarks}) do
    %{data: render_many(bookmarks, Bookmark.BookmarkView, "bookmark.json")}
  end

  def render("show.json", %{bookmark: bookmark}) do
    %{data: render_one(bookmark, Bookmark.BookmarkView, "bookmark.json")}
  end

  def render("bookmark.json", %{bookmark: bookmark}) do
    %{id: bookmark.id,
      nome: bookmark.nome,
      link: bookmark.link,
      descricao: bookmark.descricao,
      tags: Enum.map(bookmark.tags, &(&1.nome))}
  end
end
