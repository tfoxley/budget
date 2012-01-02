class AddCategoryRemoveName < ActiveRecord::Migration
  def self.up
    remove_column :budgets, :name
    add_column :budgets, :category_id, :integer
  end

  def self.down
    add_column :budgets, :name, :string
    remove_column :budgets, :category_id
  end
end
