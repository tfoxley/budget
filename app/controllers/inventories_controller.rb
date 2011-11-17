class InventoriesController < ApplicationController
  before_filter :authorize
  
  # GET /inventories
  def index
    @inventories = Inventory.find(:all, :order => 'name asc')

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /inventories/1
  def show
    @inventory = Inventory.find(params[:id])
    @inventory_items = @inventory.inventory_items.sort { |a, b| a.name <=> b.name }

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /inventories/new
  def new
    @inventory = Inventory.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /inventories/1/edit
  def edit
    @inventory = Inventory.find(params[:id])
  end

  # POST /inventories
  def create
    @inventory = Inventory.new(params[:inventory])

    respond_to do |format|
      if @inventory.save
        format.html { redirect_to(@inventory, :notice => 'Inventory was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /inventories/1
  def update
    @inventory = Inventory.find(params[:id])

    respond_to do |format|
      if @inventory.update_attributes(params[:inventory])
        format.html { redirect_to(@inventory, :notice => 'Inventory was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /inventories/1
  def destroy
    @inventory = Inventory.find(params[:id])
    @inventory.destroy

    respond_to do |format|
      format.html { redirect_to(inventories_url) }
    end
  end
end
