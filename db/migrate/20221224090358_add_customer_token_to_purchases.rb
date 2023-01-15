class AddCustomerTokenToPurchases < ActiveRecord::Migration[6.0]
  def change
    add_column :purchases, :customer_token, :string, null: false
  end
end
