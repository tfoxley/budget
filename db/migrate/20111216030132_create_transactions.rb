class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.integer :category_id
      t.date :date
      t.float :amount
      t.string :to

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
