class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
      t.references :order, foreign_key: { to_table: :orders}
      t.references :item, foreign_key: { to_table: :items}
      t.integer :price
      t.integer :amount
      t.integer :making_status, default: 1, null: false
      t.timestamps
    end
  end
end
