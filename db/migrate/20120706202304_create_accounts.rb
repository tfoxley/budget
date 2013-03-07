class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :name
      t.float :actual_balance
      t.float :reconciled_balance
      t.boolean :default

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
