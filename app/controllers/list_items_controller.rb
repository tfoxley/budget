class ListItemsController < ApplicationController
  before_filter :authorize
  
  # GET /list_items/new
  def new
    @list_item = ListItem.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /list_items/1/edit
  def edit
    @list_item = ListItem.find(params[:id])
    
    respond_to do |format|
      format.html # edit.html.erb
    end
  end

  # POST /list_items
  def create
    @list_item = ListItem.new(params[:list_item])

    respond_to do |format|
      if @list_item.save
        format.html { redirect_to('/lists/' + @list_item.list_id.to_s, :notice => 'List item was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /list_items/1
  def update
    @list_item = ListItem.find(params[:id])

    respond_to do |format|
      if @list_item.update_attributes(params[:list_item])
        format.html { redirect_to('/lists/' + @list_item.list_id.to_s, :notice => 'List item was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def complete
    @id = params[:id]
    @list_item = ListItem.find(@id)
    
    respond_to do |format|
      if @list_item.update_attributes(:completed => true)
        format.js { render :template => "/list_items/complete.rjs" }
      end
    end
  end
  
  def incomplete
    @id = params[:id]
    @list_item = ListItem.find(@id)
    
    respond_to do |format|
      if @list_item.update_attributes(:completed => false)
        format.js { render :template => "/list_items/incomplete.rjs" }
      end
    end
  end

  def quick_add
    @list_item = ListItem.new(params[:list_item])
    respond_to do |format|
      if @list_item.save
        format.js { render :template => "/list_items/quick_add.rjs" }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # DELETE /list_items/1
  def destroy
    @list_item = ListItem.find(params[:id])
    list_id = @list_item.list_id
    @list_item.destroy

    respond_to do |format|
      format.js { render :template => "/list_items/quick_delete.rjs" }
      format.html { redirect_to('/lists/' + list_id.to_s, :notice => 'List item was successfully deleted.') }
    end
  end
end
