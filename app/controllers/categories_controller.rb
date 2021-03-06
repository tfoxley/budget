class CategoriesController < ApplicationController
  before_filter :authorize
  
  # GET /categories
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
      budget_amount = x.budget_amount.blank? ? 0.0 : x.budget_amount
      percent =  budget_amount > 0.0 ? trans_total / budget_amount : 0.0
      percent = percent * 100

      @budgets << [x.id, x.name, budget_amount, trans_total, percent.to_i]
    end

    # build links for the next and previous months
    next_m = (@cur_date >> 1)
    prev_m = (@cur_date << 1)
    @next_link = "/categories/" + next_m.strftime("%Y") + "/" + next_m.strftime("%m")
    @prev_link = "/categories/" + prev_m.strftime("%Y") + "/" + prev_m.strftime("%m")

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  # GET /categories/:id
  def manage
    @categories = Category.find(:all, :order => "name")
    
    @cur_date = Date.current
    unless params[:month].blank?
      @cur_date = Date.new(params[:year].to_i, params[:month].to_i, 1)
    end
    @current = @cur_date.strftime("%B %Y")
    
    @new_link = "/categories/new/" +  @cur_date.strftime("%Y")  + "/" + @cur_date.strftime("%m")

    respond_to do |format|
      format.html # manage.html.erb
    end
  end

  # GET /categories/new
  def new
    @cur_date = Date.current
    unless params[:month].blank?
      @cur_date = Date.new(params[:year].to_i, params[:month].to_i, 1)
    end
    
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /categories/1/edit
  def edit
    @cur_date = Date.current
    unless params[:month].blank?
      @cur_date = Date.new(params[:year].to_i, params[:month].to_i, 1)
    end
    
    @category = Category.find(params[:id])
    unless @category.budget_amount.blank?
      @category.budget_amount = sprintf( "%0.02f", @category.budget_amount)
    end
    
    respond_to do |format|
      format.html # edit.html.erb
    end
  end

  # POST /categories
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to(categories_url + "/manage/" + params[:year] + "/" + params[:month], :notice => 'Category was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /categories/1
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to(categories_url + "/manage/" + params[:year] + "/" + params[:month], :notice => 'Category was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /categories/1
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to(categories_url + "/manage/") }
    end
  end
end
