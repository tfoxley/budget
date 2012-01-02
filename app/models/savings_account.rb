class SavingsAccount < ActiveRecord::Base
  validates :name,  :presence => true
end
