class Category < ActiveRecord::Base
  has_many :transaction
  has_one :budget
end
