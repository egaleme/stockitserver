defmodule StockitServer.Web.PageController do
  use StockitServer.Web, :controller

  def index(conn, _params) do
    	conn
		|> put_status(200)
		|> json(%{Welcome: "Hello"})
  end
end
