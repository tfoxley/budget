class Inventory < ActiveRecord::Base
  has_many :inventory_items, :dependent => :destroy
end
