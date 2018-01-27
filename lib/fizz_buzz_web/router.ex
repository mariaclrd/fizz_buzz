defmodule FizzBuzzWeb.Router do
  use FizzBuzzWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FizzBuzzWeb do
    pipe_through :browser

    get "/", NumberController, :index
  end

   scope "/api", FizzBuzzWeb do
     pipe_through :api

     get "/numbers", NumberController, :index
     post "/favourites", FavouriteController, :create
   end
end
