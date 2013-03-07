class InventoryItem < ActiveRecord::Base
  belongs_to :inventory
  
  validates_presence_of :name
end
