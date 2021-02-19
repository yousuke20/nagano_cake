class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy
  
  with_options presence: true do
    validates :last_name
    validates :last_name_kana
    validates :first_name
    validates :first_name_kana
    validates :address
    validates :telephone_number
    validates :is_active
  end
  
  enum is_active: { 有効: 1, 退会: 2 }
end
