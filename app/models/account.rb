class Account < ActiveRecord::Base
  has_many :transaction
  
  validates_presence_of :name, :actual_balance, :reconciled_balance
end
