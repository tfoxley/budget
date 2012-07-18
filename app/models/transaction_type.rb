class TransactionType < ActiveRecord::Base
  has_many :transaction
  
  DEPOSIT = 1
  WITHDRAWAL = 2
end
