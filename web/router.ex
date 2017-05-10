defmodule Teamwork.Router do
  use Teamwork.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Doorman.Login.Session
    plug Teamwork.TokenVerifier
    plug Teamwork.ParentSession
    if Mix.env == :test do
      plug Teamwork.Plug.SessionBackdoor
    end
  end

  if Mix.env == :dev do
    forward "/sent_emails", Bamboo.EmailPreviewPlug
  end

  scope "/", Teamwork do
    pipe_through :browser # Use the default browser stack
    resources "/session", SessionController, only: [:new, :create, :delete], singleton: true
    resources "/parents", ParentController, only: [:new, :create]
    get "/", ParentController, :new
    resources "/tokenized_parent_email", TokenizedParentEmailController, only: [:create]
  end

  scope "/", Teamwork do
    pipe_through [:browser, Teamwork.RequireParent]
    resources "/parents", ParentController, only: [:show]
    resources "/parents", ParentController, only: [] do
      resources "/players", PlayerController, only: [:create, :new]
    end
    resources "/players", PlayerController, only: [:show]
  end

  scope "/admin", Teamwork, as: :admin do
    pipe_through [:browser, Teamwork.RequireAdmin]
    resources "/users", Admin.UserController
  end
end
