class Order < ApplicationRecord
  
  has_many :order_details
  belongs_to :customer
  
  enum status: { 入金待ち: 1, 入金確認: 2, 製作中: 3, 発送準備中: 4, 発送済み: 5}
  enum payment_method: { クレジットカード: 1, 銀行振込: 0 } # 銀行振込を2に設定するとエラーが発生するため、銀行振込を0に設定した
  
end
