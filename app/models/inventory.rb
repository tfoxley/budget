class Inventory < ActiveRecord::Base
  has_many :inventory_items, :dependent => :destroy
  
  validates_presence_of :name
end
