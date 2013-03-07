class AddAccountToTransactions < ActiveRecord::Migration
  def self.up
    add_column :transactions, :account_id, :integer
    
    Transaction.reset_column_information
    
    account_id = 1
    if Account.count < 1
      account = Account.new
      account.name = "Default Account (change name)"
      account.actual_balance = 0
      account.reconciled_balance = 0
      account.default = true
      account.save
      account_id = account.id
    else
      account_id = Account.first.id
    end
    
    Transaction.all.each do |t|
      t.account_id = account_id
      t.save
    end
  end

  def self.down
    remove_column :transactions, :account_id
  end
end
