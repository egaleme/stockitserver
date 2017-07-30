defmodule StockitServer.Web.AccessTokenChannel do
  use StockitServer.Web, :channel


  def join("access_token:enter", _payload, socket) do
    {:ok, socket}
  end

  def handle_in("create", %{"user" => %{"username" => username, "password" => password}}, socket) do
    case StockitServer.Web.Auth.login_by_username_and_pass(username, password) do
      {:ok, user} ->
        {:ok, jwt, _claims} = Guardian.encode_and_sign(user, :access)
        resp = %{data: %{access_token: jwt}}
        push socket, "create", resp
        {:noreply, socket}

      {:err, :notverified} ->
        {:reply, {:error, %{errors: "please verify your email address"}}, socket}
      {:err, :unauthorized} ->
        {:reply, {:error, %{errors: "user password incorrect"}}, socket}
      {:err, :notfound} ->
        {:reply, {:error, %{errors: "user not found"}}, socket}
    end
  end

end
