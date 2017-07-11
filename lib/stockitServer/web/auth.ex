defmodule StockitServer.Web.Auth do
	import Hasher
	alias StockitServer.Account

	def login_by_username_and_pass(username, given_pass) do
		user = Account.get_by(username)

		cond do
			user && check_password_hash(given_pass, user.password_hash) ->
				{:ok, user}
			user && !check_password_hash(given_pass, user.password_hash)->
				{:err, :unauthorized}
			true ->
				{:err, :notfound}
		end
	end

end