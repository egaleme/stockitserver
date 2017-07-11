defmodule StockitServer.Repo.Migrations.CreateStockProduct do
  use Ecto.Migration

  def change do
	   create table(:stock_products) do
	      add :name, :string
	      add :batchno, :string
	      add :price, :float
	      add :quantity, :integer
	      add :expiringdate, :string
	      add :productid, :integer
	      add :user_id, references(:account_users, on_delete: :nothing)

	      timestamps()
	  end
	  create index(:stock_products, [:user_id])
  end
end
