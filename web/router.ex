defmodule Teamwork.Router do
  use Teamwork.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Doorman.Login.Session
    if Mix.env == :test do
      plug Teamwork.Plug.SessionBackdoor
    end
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Teamwork do
    pipe_through :browser # Use the default browser stack
    resources "/session", SessionController, only: [:new, :create, :delete], singleton: true

    get "/", PageController, :index
  end

  scope "/admin", Teamwork, as: :admin do
    pipe_through [:browser, Teamwork.RequireAdmin]
    resources "/users", Admin.UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Teamwork do
  #   pipe_through :api
  # end
end
