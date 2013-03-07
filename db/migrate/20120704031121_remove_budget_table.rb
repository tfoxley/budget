class RemoveBudgetTable < ActiveRecord::Migration
  def self.up
    drop_table :budgets
  end

  def self.down
    create_table :budgets do |t|
      t.integer :category_id
      t.float :amount

      t.timestamps
    end
  end
end
