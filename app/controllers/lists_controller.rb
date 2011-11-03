class ListsController < ApplicationController
  before_filter :authorize
  
  # GET /lists
  def index
    @lists = List.find(:all, :order => 'name asc')

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /lists/1
  def show
    @list = List.find(params[:id])
    @title = @list.name.length > 12 ? @list.name[0, 12] + '...' : @list.name
    @complete_items = ListItem.find(:all, :conditions => ["list_id = ? AND completed = ?", params[:id], true], :order => 'updated_at asc')
    @incomplete_items = ListItem.find(:all, :conditions => ["list_id = ? AND completed = ?", params[:id], false], :order => 'updated_at desc')

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /lists/new
  def new
    @list = List.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /lists/1/edit
  def edit
    @list = List.find(params[:id])
  end

  # POST /lists
  def create
    @list = List.new(params[:list])

    respond_to do |format|
      if @list.save
        format.html { redirect_to("/lists", :notice => 'List was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /lists/1
  def update
    @list = List.find(params[:id])

    respond_to do |format|
      if @list.update_attributes(params[:list])
        format.html { redirect_to("/lists", :notice => 'List was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /lists/1
  def destroy
    @list = List.find(params[:id])
    @list.destroy
    ListItem.destroy_all(:list_id => params[:id])

    respond_to do |format|
      format.html { redirect_to('/lists', :notice => 'List was successfully deleted.') }
    end
  end
end
