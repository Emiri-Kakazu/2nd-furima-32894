class RemoveCustomerTokenFromPurchases < ActiveRecord::Migration[6.0]
  def change
    remove_column :purchases, :customer_token, :string
  end
end
