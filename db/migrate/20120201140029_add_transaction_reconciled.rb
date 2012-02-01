class AddTransactionReconciled < ActiveRecord::Migration
  def self.up
    add_column :transactions, :reconciled, :boolean, :default => false
    Transaction.update_all ["reconciled = ?", false]
  end

  def self.down
    remove_column :transactions, :reconciled
  end
end
