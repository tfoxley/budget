class InventoryItem < ActiveRecord::Base
  belongs_to :inventory
  
  validates :name,  :presence => true
end
