class RemoveAccounts < ActiveRecord::Migration
  def self.up
    remove_column :transactions, :account_id
    drop_table :accounts
  end

  def self.down
    create_table :accounts do |t|
      t.string :name
      t.float :actual_balance
      t.float :reconciled_balance
      t.boolean :default

      t.timestamps
    end
    
    add_column :transactions, :account_id, :integer
  end
end