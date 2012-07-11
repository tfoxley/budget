class AddDefaultCategory < ActiveRecord::Migration
  def self.up
    if Category.count < 1
      cat = Category.new
      cat.name = "Uncategorized"
      cat.save
    end
  end

  def self.down
  end
end
