class RemoveTransactionTypes < ActiveRecord::Migration
  def self.up
    remove_column :transactions, :transaction_type_id
    drop_table :transaction_types
  end

  def self.down
    create_table :transaction_types do |t|
      t.string :name

      t.timestamps
    end
    
    TransactionType.reset_column_information
    
    type1 = TransactionType.new
    type1.name = "Deposit"
    type1.save
    
    type2 = TransactionType.new
    type2.name = "Withdrawal"
    type2.save
    
    add_column :transactions, :transaction_type_id, :integer
    
    Transaction.reset_column_information
    
    Transaction.all.each do |t|
      t.transaction_type_id = 2
      t.save
    end
  end
end
