class Category < ActiveRecord::Base
  has_many :transaction
  has_one :budget
  
  validates_presence_of :name
end
