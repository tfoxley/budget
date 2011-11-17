class List < ActiveRecord::Base
  has_many  :list_items, :dependent => :destroy
end
