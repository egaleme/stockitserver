defmodule StockitServer.UserEmail do
	import Swoosh.Email

	def welcome(user) do
		new()
		|> to({user.name, user.email})
		|> from({"stockdiary", "stockdiaryapp@gmail.com"})
		|> subject("Your stockIT verification email")
		|> html_body("<h1>stockIT</h1><p>Thanks for signing up with us</p><p>Please click the link below to verify your email address</p><a href=https://stockitserver.herokuapp.com/v1/api/auth/verify_email/#{user.token}>Verify address</a>")
	end
end