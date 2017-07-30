defmodule StockitServer.Web.AccessTokenView do
	use StockitServer.Web, :view

	def render("verify_email.json", %{user: user}) do
		%{
			verified: user.email_verified
		}	
	end
end