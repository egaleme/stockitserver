defmodule StockitServer.Web.ProductChannel do
  use StockitServer.Web, :channel
  alias StockitServer.Stock
  alias StockitServer.Web.ProductView
  import Guardian.Phoenix.Socket

  def join("products:auth", %{"guardian_token" => token}, socket) do
    case sign_in(socket, token) do
      {:ok, socket, _guardian_params} ->
      #  user = current_resource(socket)
       # if user.email_verified do
        send(self(), :after_join)
        {:ok, socket}
       # else
       #  {:error, %{message: "Not authorized"}}
       # end
      {:error, _} ->
        {:error, %{reason: "unauthorized"}}
    end
  end

  def join("products:joined", %{"guardian_token" => token}, socket) do
    case sign_in(socket, token) do
      {:ok, socket, _guardian_params} ->
       
       # user = current_resource(socket)
       # if user.email_verified do
        {:ok, %{message: "Joined"}, socket}
      #else
      #  {:error, %{message: "Not authorized"}}
     # end
      {:error, _} ->
        {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_info(:after_join, socket) do
     user = current_resource(socket)
     current_user_products = assoc(user, :products)
     products = Stock.list_products(current_user_products, 19, 0)
     resp = %{data: Phoenix.View.render_many(products, ProductView, "product.json")}
     push socket, "products_loaded", resp
     {:noreply, socket}
  end

  def handle_in("load_more", %{"offset" => offset, "limit" => limit}, socket) do
     user = current_resource(socket)
     current_user_products = assoc(user, :products)
     products = Stock.list_products(current_user_products, limit, offset)
     resp = %{data: Phoenix.View.render_many(products, ProductView, "product.json")}
     push socket, "load_more", resp
     {:noreply, socket}
  end

  def handle_in("add_product", %{"product" => product_params}, socket) do
    current_user = current_resource(socket)
    case Stock.create_product(current_user, product_params) do
      {:ok, product} ->  
         resp =  %{data: Phoenix.View.render_one(product, ProductView, "show-product.json")}
        broadcast! socket, "product_added", resp
        {:noreply, socket}
      {:error, _changeset} ->
        push socket, "add_product_error", %{error: "Error. Product name is taken ٩(×̯×)۶"}
        {:noreply, socket}
    end
  end

  def handle_in("update_product", %{"productid" => productid, "product" => product_params}, socket) do
    user = current_resource(socket)
    current_user_products = assoc(user, :products)
    product = Stock.get_product!(current_user_products, productid)
    case Stock.update_product(product, product_params) do
      {:ok, product} ->
          resp =  %{data: Phoenix.View.render_one(product, ProductView, "show-product.json")}
        broadcast! socket, "product_updated", resp
        {:noreply, socket}
      {:error, _changeset} ->
        push socket, "update_product_error", %{error: "Error. Product name is taken ٩(×̯×)۶"}
        {:noreply, socket}
    end
  end

  def handle_in("delete_product", %{"productid" => productid}, socket) do
    user = current_resource(socket)
    current_user = assoc(user, :products)
    product = Stock.get_product!(current_user, productid)
    case Stock.delete_product(product) do
      {:ok, _product} ->
         broadcast! socket, "product_deleted", %{noContent: ""}
         {:noreply, socket}
      {:error, _} ->
        push socket, "delete_product_error", %{error: "Error. Product name is taken ٩(×̯×)۶"}
        {:noreply, socket}
    end
  end

end
