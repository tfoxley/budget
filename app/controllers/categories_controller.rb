class CategoriesController < ApplicationController
  # GET /categories
  def index
    @categories = Category.find(:all, :order => "name")
    selected = params[:category].blank? ? @categories[0] : @categories.collect { |c| c if c.id == params[:category].to_i }.compact[0]
    
    @cur_date = Date.current
    unless params[:month].blank?
      @cur_date = Date.new(params[:year].to_i, params[:month].to_i, 1)
    end
    @current = @cur_date.strftime("%B %Y")
    
    @transactions = Transaction.find(:all, :conditions => { :date => @cur_date.beginning_of_month..@cur_date.end_of_month, :category_id => selected.id }, :order => "date desc,id desc")

    # build links for the next and previous months
    next_m = (@cur_date >> 1)
    prev_m = (@cur_date << 1)
    @next_link = "/categories/" + next_m.strftime("%Y") + "/" + next_m.strftime("%m")
    @prev_link = "/categories/" + prev_m.strftime("%Y") + "/" + prev_m.strftime("%m")
    @new_link = "/categories/new/" +  @cur_date.strftime("%Y")  + "/" + @cur_date.strftime("%m")
    @edit_link = "/categories/" + selected.id.to_s + "/edit/" +  @cur_date.strftime("%Y")  + "/" + @cur_date.strftime("%m")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /categories/new
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to(categories_url + "/" + params[:year] + "/" + params[:month], :notice => 'Category was successfully created.') }
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
        format.html { redirect_to(categories_url + "/" + params[:year] + "/" + params[:month], :notice => 'Category was successfully updated.') }
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
      format.html { redirect_to(categories_url) }
    end
  end
end
