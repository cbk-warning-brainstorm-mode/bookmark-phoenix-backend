defmodule Bookmark.Repo.Migrations.CreateTag do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :nome, :string

      timestamps
    end

  end
end
