class InventoryItemsController < ApplicationController
  before_filter :authorize
  
  # GET /inventory_items/new
  def new
    @inventory_item = InventoryItem.new

    respond_to do |format|
      format.html
      format.mobile
    end
  end

  # GET /inventory_items/1/edit
  def edit
    @inventory_item = InventoryItem.find(params[:id])
    respond_to do |format|
      format.html
      format.mobile
    end
  end

  # POST /inventory_items
  def create
    @inventory_item = InventoryItem.new(params[:inventory_item])

    respond_to do |format|
      if @inventory_item.save
        format.html { redirect_to('/inventories/' + @inventory_item.inventory_id.to_s, :notice => 'Inventory item was successfully created.') }
        format.mobile { redirect_to('/inventories/' + @inventory_item.inventory_id.to_s, :notice => 'Inventory item was successfully created.') }
      else
        format.html { render :action => "new" }
        format.mobile { render :action => "new" }
      end
    end
  end

  # PUT /inventory_items/1
  def update
    @inventory_item = InventoryItem.find(params[:id])

    respond_to do |format|
      if @inventory_item.update_attributes(params[:inventory_item])
        format.html { redirect_to('/inventories/' + @inventory_item.inventory_id.to_s, :notice => 'Inventory item was successfully updated.') }
        format.mobile { redirect_to('/inventories/' + @inventory_item.inventory_id.to_s, :notice => 'Inventory item was successfully updated.') }
      else
        format.html { render :action => "edit" }
        format.mobile { render :action => "edit" }
      end
    end
  end
  
  def increase_quantity
    @inventory_item = InventoryItem.find(params[:id])
    @quantity = @inventory_item.quantity + 1
    @id = @inventory_item.id
    
    respond_to do |format|
      if @inventory_item.update_attributes(:quantity => @quantity)
        flash[:notice] = 'Item was successfully updated.'
        format.html { redirect_to '/inventories/' + @inventory_item.inventory_id.to_s }
        format.js { render :template => "/inventory_items/update.rjs" }
      else
        format.html { render :action => "edit" }
        format.js do
            page.redirect_to "/inventories" + @inventory_item.inventory_id.to_s
        end
      end
    end
  end
  
  def decrease_quantity
    @inventory_item = InventoryItem.find(params[:id])
    @quantity = @inventory_item.quantity - 1
    @id = @inventory_item.id
    
    respond_to do |format|
      if @inventory_item.update_attributes(:quantity => @quantity)
        flash[:notice] = 'Item was successfully updated.'
        format.html { redirect_to '/inventories/' + @inventory_item.inventory_id.to_s }
        format.js { render :template => "/inventory_items/update.rjs" }
      else
        format.html { render :action => "edit" }
        format.js do
            page.redirect_to "/inventories" + @inventory_item.inventory_id.to_s
        end
      end
    end
  end

  # DELETE /inventory_items/1
  def destroy
    @inventory_item = InventoryItem.find(params[:id])
    @inventory = @inventory_item.inventory_id
    @inventory_item.destroy

    respond_to do |format|
      format.html { redirect_to '/inventories/' + @inventory.to_s }
      format.mobile { redirect_to '/inventories/' + @inventory.to_s }
    end
  end
end
