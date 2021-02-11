class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :genre, foreign_key: { to_table: :genres}, default: 1, null: false
      t.string :name
      t.string :image
      t.text :introduction
      t.integer :price
      t.integer :is_active, default: 1, null: false
      t.timestamps
    end
  end
end
