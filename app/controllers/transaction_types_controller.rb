class TransactionTypesController < ApplicationController
  before_filter :authorize
  
  # GET /transaction_types
  def index
    @transaction_types = TransactionType.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /transaction_types/1
  def show
    @transaction_type = TransactionType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /transaction_types/new
  def new
    @transaction_type = TransactionType.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /transaction_types/1/edit
  def edit
    @transaction_type = TransactionType.find(params[:id])
  end

  # POST /transaction_types
  def create
    @transaction_type = TransactionType.new(params[:transaction_type])

    respond_to do |format|
      if @transaction_type.save
        format.html { redirect_to(@transaction_type, :notice => 'Transaction type was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /transaction_types/1
  def update
    @transaction_type = TransactionType.find(params[:id])

    respond_to do |format|
      if @transaction_type.update_attributes(params[:transaction_type])
        format.html { redirect_to(@transaction_type, :notice => 'Transaction type was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /transaction_types/1
  def destroy
    @transaction_type = TransactionType.find(params[:id])
    @transaction_type.destroy

    respond_to do |format|
      format.html { redirect_to(transaction_types_url) }
    end
  end
end
