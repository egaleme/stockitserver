defmodule StockitServer.Web.UserChannel do
  use StockitServer.Web, :channel
  alias StockitServer.Account
  alias StockitServer.Web.UserView

  def join("user:lobby", _payload, socket) do
      {:ok, socket}
  end

  def handle_in("create:user", %{"user" => user_params}, socket) do
    case Account.create_user(user_params) do
      {:ok, user} ->
        resp = %{data: Phoenix.View.render_one(user, UserView, "user.json")}
        push socket, "create:user", resp
        {:reply, :ok, socket}
      {:error, _changeset} ->
        {:reply, {:error, %{errors: "Could not create user"}}}
    end
  end

end
