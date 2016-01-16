defmodule Bookmark.TagView do
  use Bookmark.Web, :view

  def render("index.json", %{tags: tags}) do
    %{data: render_many(tags, Bookmark.TagView, "tag.json")}
  end

  def render("show.json", %{tag: tag}) do
    %{data: render_one(tag, Bookmark.TagView, "tag.json")}
  end

  def render("tag.json", %{tag: tag}) do
    %{id: tag.id,
      nome: tag.nome}
  end
end
