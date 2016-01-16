defmodule Bookmark.Repo.Migrations.CreateBookmark do
  use Ecto.Migration

  def change do
    create table(:bookmarks) do
      add :nome, :string
      add :link, :string
      add :descricao, :text

      timestamps
    end

  end
end
