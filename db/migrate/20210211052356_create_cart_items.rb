class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.references :item, foreign_key: { to_table: :items}
      t.references :customer, foreign_key: { to_table: :customers}
      t.integer :amount
      t.timestamps
    end
  end
end
