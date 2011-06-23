class AddDefaultValueForCompleted < ActiveRecord::Migration
  def self.up
    remove_column :list_items, :completed
    add_column :list_items, :completed, :boolean, :default => 0
  end

  def self.down
  end
end
