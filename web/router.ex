defmodule Bookmark.Router do
  use Bookmark.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Bookmark do
    pipe_through :api

    resources "/tags", TagController, except: [:new, :edit]
    resources "/bookmarks", BookmarkController, except: [:new, :edit]
  end
end
