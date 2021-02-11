class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :customer, foreign_key: { to_table: :customers}
      t.string :address
      t.string :name
      t.integer :postal_code
      t.integer :shipping_cost
      t.integer :payment
      t.integer :payment_method, default: 1, null: false
      t.integer :status, default: 1, null: false
      t.timestamps
    end
  end
end
