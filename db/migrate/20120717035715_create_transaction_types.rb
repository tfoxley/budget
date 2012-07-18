class CreateTransactionTypes < ActiveRecord::Migration
  def self.up
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
  end

  def self.down
    drop_table :transaction_types
  end
end
