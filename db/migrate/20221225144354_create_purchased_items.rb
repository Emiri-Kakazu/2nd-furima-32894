class CreatePurchasedItems < ActiveRecord::Migration[6.0]
  def change
    create_table :purchased_items do |t|
      t.references :item, foreign_key: true
      t.timestamps
    end
  end
end