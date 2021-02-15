class Item < ApplicationRecord
  
  belongs_to :genre
  has_many :order_details
  has_many :cart_items
  
  attachment :image
  enum is_active: { 販売中: 1, 販売停止中: 2 }
  
end
