defmodule Bookmark.Repo.Migrations.CreateBookmarkTag do
  use Ecto.Migration

  def change do
    create table(:bookmark_tags) do
      add :bookmark_id, :integer
      add :tag_id, :integer

      timestamps
    end

  end
end
