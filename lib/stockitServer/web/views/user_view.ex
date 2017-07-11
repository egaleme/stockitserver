defmodule StockitServer.Web.UserView do
  use StockitServer.Web, :view
  alias StockitServer.Web.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      username: user.username,
      email: user.email,
      token: user.token,
      verified: user.email_verified}
  end

  def render("error.json", %{message: message}) do
    %{
      error: message
    }
  end

  def render("show.json-api", %{data: user}) do
    %{
      data: user
    }
  end

  def render("username", %{user: user}) do
    user.username
  end
end
