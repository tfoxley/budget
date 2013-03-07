module CategoriesHelper
  def numeric?(object)
    true if Float(object) rescue false
  end
end
