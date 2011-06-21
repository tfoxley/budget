class AddCompletedToListItems < ActiveRecord::Migration
  def self.up
    add_column :list_items, :completed, :boolean
  end

  def self.down
    remove_column :list_items, :completed
  end
end
