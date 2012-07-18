class AddTransactionTypeToTransactions < ActiveRecord::Migration
  def self.up
    add_column :transactions, :transaction_type_id, :integer
    
    Transaction.reset_column_information
    
    Transaction.all.each do |t|
      t.transaction_type_id = 2
      t.save
    end
  end

  def self.down
    remove_column :transactions, :transaction_type_id
  end
end
