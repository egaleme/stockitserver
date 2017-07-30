defmodule StockitServer.Web.Router do
  use StockitServer.Web, :router

  pipeline :api do
    plug :accepts, ["json", "json-api"]
    plug JaSerializer.Deserializer
  end

  pipeline :api_auth do  
    plug :accepts, ["json", "json-api"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug JaSerializer.Deserializer
  end 

  scope "/v1/api/auth", StockitServer.Web do
    pipe_through :api
     get "/verify_email/:token", AccessTokenController, :verify_email 
  end

   scope "/v1/api", StockitServer.Web do
    pipe_through :api_auth
   # get "/verify_email/:token", AccessTokenController, :verify_email 
  end
end
