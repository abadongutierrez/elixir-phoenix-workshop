defmodule PlugTest.Router do
  use PlugTest.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    #plug PlugTest.Plug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PlugTest do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/test", PageController, :test
  end

  # Other scopes may use custom stacks.
  # scope "/api", PlugTest do
  #   pipe_through :api
  # end
end
