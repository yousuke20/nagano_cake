class Item < ApplicationRecord
  
  has_many :order_details
  has_many :cart_items
  
  attachment :image
  enum genre_id: { ケーキ: 1, プリン: 2, 焼き菓子: 3, キャンディ: 4}
  enum is_active: { 販売中: 1, 販売停止中: 2 }
  
end
