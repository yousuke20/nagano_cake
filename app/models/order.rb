class Order < ApplicationRecord
  
  enum payment_method: { 入金待ち: 1, 入金確認: 2, 製作中: 3, 発送準備中: 4, 発送済み: 5}
  enum status: { クレジットカード: 1, 銀行振込: 2 }
  
end
