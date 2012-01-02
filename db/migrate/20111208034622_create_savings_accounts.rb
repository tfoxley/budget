class CreateSavingsAccounts < ActiveRecord::Migration
  def self.up
    create_table :savings_accounts do |t|
      t.string :name
      t.float :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :savings_accounts
  end
end
