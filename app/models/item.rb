class Item < ApplicationRecord
  
  belongs_to :genre
  has_many :order_details
  has_many :cart_items
  
  with_options presence: true do
    validates :image
    validates :name
    validates :introduction
    validates :price
    validates :is_active
  end
  
  attachment :image
  enum is_active: { 販売中: 1, 販売停止中: 2 }
  
end
