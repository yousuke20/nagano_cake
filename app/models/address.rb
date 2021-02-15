class Address < ApplicationRecord
  belongs_to :customer
  
  composed_of :fulladdress,
    :class_name => "Fulladdress",
    :mapping => [
      [:postal_code, :postal_code],
      [:address, :address],
      [:name, :name]
    ]
end

class Fulladdress
  attr_reader :postal_code, :address, :name
  
  def initialize(postal_code, address, name)
    @postal_code = postal_code
    @address = address
    @name = name
  end
  
  def to_s
    [@postal_code, @address, @name].compact.join("")
  end
end  
