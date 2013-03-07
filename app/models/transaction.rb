class Transaction < ActiveRecord::Base
  belongs_to :category
  
  validates_presence_of :amount, :category_id, :date, :to
end
