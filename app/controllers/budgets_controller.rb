class BudgetsController < ApplicationController
  # GET /budgets
  def index
    @cur_date = Date.current
    unless params[:month].blank?
      @cur_date = Date.new(params[:year].to_i, params[:month].to_i, 1)
    end
    @current = @cur_date.strftime("%B %Y")
    
    #budgets = Budget.all.sort { |a, b| a.category.name <=> b.category.name }
    categories = Category.find(:all, :order => "name")
    @budgets = []
    transactions = Transaction.find(:all, :conditions => { :date => @cur_date.beginning_of_month..@cur_date.end_of_month })

    categories.each do |x|
      trans_total = 0.0
      transactions.each { |a| trans_total += a.amount if a.category_id == x.id }
      budget = x.budget
      amount = budget.nil? ? "-------" : budget.amount
      budget_id = budget.nil? ? 0 : budget.id
      @budgets << [x.name, amount, trans_total, budget_id]
    end
    
    # build links for the next and previous months
    next_m = (@cur_date >> 1)
    prev_m = (@cur_date << 1)
    @next_link = "/budgets/" + next_m.strftime("%Y") + "/" + next_m.strftime("%m")
    @prev_link = "/budgets/" + prev_m.strftime("%Y") + "/" + prev_m.strftime("%m")
    @new_link = "/budgets/new/" +  @cur_date.strftime("%Y")  + "/" + @cur_date.strftime("%m")

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /budgets/new
  def new
    @budget = Budget.new
    
    budgeted = Budget.all.collect { |b| b.category_id }
    budgeted = 0 if budgeted.blank?
    @categories = Category.where(["id NOT IN (?)", budgeted]).collect { |c| [ c.name, c.id ] }
    @categories.sort! { |a,b| a[0] <=> b[0] }

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /budgets/1/edit
  def edit
    @budget = Budget.find(params[:id])
    
    budgeted = Budget.all.collect { |b| b.category_id unless b.id == @budget.id }.compact
    @categories = Category.where(["id NOT IN (?)", budgeted]).collect { |c| [ c.name, c.id ] }
    @categories.sort! { |a,b| a[0] <=> b[0] }
    
    @budget.amount = sprintf( "%0.02f", @budget.amount)
  end

  # POST /budgets
  def create
    @budget = Budget.new(params[:budget])

    respond_to do |format|
      if @budget.save
        format.html { redirect_to(budgets_url + "/" + params[:year] + "/" + params[:month], :notice => 'Budget was successfully created.') }
      else
        budgeted = Budget.all.collect { |b| b.category_id }
        budgeted = 0 if budgeted.blank?
        @categories = Category.where(["id NOT IN (?)", budgeted]).collect { |c| [ c.name, c.id ] }
        @categories.sort! { |a,b| a[0] <=> b[0] }
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /budgets/1
  def update
    @budget = Budget.find(params[:id])

    respond_to do |format|
      if @budget.update_attributes(params[:budget])
        format.html { redirect_to(budgets_url + "/" + params[:year] + "/" + params[:month], :notice => 'Budget was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /budgets/1
  def destroy
    @budget = Budget.find(params[:id])
    @budget.destroy

    respond_to do |format|
      format.html { redirect_to(budgets_url) }
    end
  end
end
