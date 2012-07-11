class ListsController < ApplicationController
  before_filter :authorize
  
  # GET /lists
  def index
    @lists = List.find(:all, :order => 'name asc')

    respond_to do |format|
      format.html # index.html.erb
      format.mobile
    end
  end

  # GET /lists/1
  def show
    @list = List.find(params[:id])
    list_items = @list.list_items
    @complete_items = list_items.collect { |x| x if x.completed }.compact.sort { |a, b| a.updated_at <=> b.updated_at }
    @incomplete_items = list_items.collect { |x| x unless x.completed }.compact.sort { |a, b| b.updated_at <=> a.updated_at }

    respond_to do |format|
      format.html # show.html.erb
      format.mobile
    end
  end

  # GET /lists/new
  def new
    @list = List.new

    respond_to do |format|
      format.html # new.html.erb
      format.mobile
    end
  end

  # GET /lists/1/edit
  def edit
    @list = List.find(params[:id])
    
    respond_to do |format|
      format.html # edit.html.erb
      format.mobile
    end
  end

  # POST /lists
  def create
    @list = List.new(params[:list])

    respond_to do |format|
      if @list.save
        format.html { redirect_to("/lists", :notice => 'List was successfully created.') }
        format.mobile { redirect_to("/lists", :notice => 'List was successfully created.') }
      else
        format.html { render :action => "new" }
        format.mobile { render :action => "new" }
      end
    end
  end

  # PUT /lists/1
  def update
    @list = List.find(params[:id])

    respond_to do |format|
      if @list.update_attributes(params[:list])
        format.html { redirect_to("/lists", :notice => 'List was successfully updated.') }
        format.mobile { redirect_to("/lists", :notice => 'List was successfully updated.') }
      else
        format.html { render :action => "edit" }
        format.mobile { render :action => "edit" }
      end
    end
  end

  # DELETE /lists/1
  def destroy
    @list = List.find(params[:id])
    @list.destroy
    

    respond_to do |format|
      format.html { redirect_to('/lists', :notice => 'List was successfully deleted.') }
      format.mobile { redirect_to('/lists', :notice => 'List was successfully deleted.') }
    end
  end
end
