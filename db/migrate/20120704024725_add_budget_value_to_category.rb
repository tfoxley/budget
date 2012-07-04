class AddBudgetValueToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :budget_amount, :float
    
    Category.reset_column_information
    
    budgets = Budget.find(:all)
    
    budgets.each do |bud|
      cat = Category.find(bud.category_id)
      cat.budget_amount = bud.amount
      cat.save
    end
  end

  def self.down
    remove_column :categories, :budget_amount
  end
end
