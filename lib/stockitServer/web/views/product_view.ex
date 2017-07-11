defmodule StockitServer.Web.ProductView do
  use StockitServer.Web, :view
  alias StockitServer.Web.ProductView

  def render("index.json", %{products: products}) do
    %{data: render_many(products, ProductView, "product.json")}
  end

  def render("show.json", %{product: product}) do
    %{data: render_one(product, ProductView, "show-product.json")}
  end

  def render("product.json", %{product: product}) do
    %{id: product.id,
      name: product.name,
      batchno: product.batchno,
      price: product.price,
      quantity: product.quantity,
      expiringdate: product.expiringdate,
      productid: product.productid,
      created_at: product.inserted_at,
      user: render_one(product.user, StockitServer.Web.UserView, "username")
    }
  end

 def render("show-product.json", %{product: product}) do
    %{
      id: product.id,
      name: product.name,
      batchno: product.batchno,
      price: product.price,
      quantity: product.quantity,
      productid: product.productid,
      expiringdate: product.expiringdate,
      created_at: product.inserted_at
    }
  end

  def render("error.json", %{message: message}) do
    %{
      error: message
    }
  end
end
