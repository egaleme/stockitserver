defmodule StockitServer.Stock.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias StockitServer.Stock.Product


  schema "stock_products" do
    field :batchno, :string
    field :expiringdate, :string
    field :name, :string
    field :price, :float
    field :productid, :integer
    field :quantity, :integer
    belongs_to  :user, StockitServer.Account.User

    timestamps()
  end

  @doc false
  def changeset(%Product{} = product, attrs) do
    product
    |> cast(attrs, [:name, :batchno, :price, :quantity, :expiringdate, :productid])
    |> validate_required([:name, :price, :quantity, :expiringdate, :productid])
  end
end
