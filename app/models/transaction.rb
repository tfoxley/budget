class Transaction < ActiveRecord::Base
  belongs_to :category
  belongs_to :account
  
  validates_presence_of :amount, :category_id, :date, :to
end
