defmodule StocitServer.Web.PageController do
  use StocitServer.Web, :controller

  def index(conn, _params) do
    	conn
		|> put_status(200)
		|> json(%{Welcome: "Hello"})
  end
end
