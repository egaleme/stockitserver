defmodule StockitServer.AccessTokenView do
	use StockitServer.Web, :view

	def render("verify_email.json", %{user: user}) do
		%{
			data: %{
				verified: user.email_verified
			}
		}
	end
end