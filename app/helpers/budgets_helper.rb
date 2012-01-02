module BudgetsHelper
  
  def numeric?(object)
    true if Float(object) rescue false
  end
end
