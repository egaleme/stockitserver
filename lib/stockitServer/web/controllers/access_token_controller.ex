defmodule StockitServer.AccessTokenController do
	use StockitServer.Web, :controller

	alias StockitServer.Account
	alias StockitServer.Account.User

	 action_fallback StockitServer.Web.FallbackController

	def verify_email(conn, %{"token" => token}) do
		user = Account.get_by_token(token)
		if user do
		   with {:ok, %User{} = user} <- Account.verify_email(user) do
			   
			 	conn
			   	|> put_status(200)
			   	|> render("verify_email.json", user: user)
			  
			end	
		else 
			conn
			|> put_status(:not_found)
			|> json(%{error: "invalid token"})
		end

	end
	
end