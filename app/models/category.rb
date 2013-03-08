class Category < ActiveRecord::Base
  has_many :transaction
  
  validates_presence_of :name, :budget_amount
end
