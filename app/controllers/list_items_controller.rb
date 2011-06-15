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

  # DELETE /list_items/1
  def destroy
    @list_item = ListItem.find(params[:id])
    @list_item.destroy

    respond_to do |format|
      format.html { redirect_to(list_items_url) }
    end
  end
end
