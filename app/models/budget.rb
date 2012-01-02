class Budget < ActiveRecord::Base
  belongs_to :category
  
  validates_presence_of :amount, :category_id
end
