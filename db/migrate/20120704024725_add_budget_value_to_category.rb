class AddBudgetValueToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :budget_amount, :float
    end
  end

  def self.down
    remove_column :categories, :budget_amount
  end
end
