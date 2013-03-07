class TransactionsController < ApplicationController
  before_filter :authorize
  
  # GET /transactions
  def index
    @cur_date = Date.current
    unless params[:month].blank?
      @cur_date = Date.new(params[:year].to_i, params[:month].to_i, 1)
    end
    @current = @cur_date.strftime("%B %Y")
    
    @transactions = Transaction.find(:all, :conditions => { :date => @cur_date.beginning_of_month..@cur_date.end_of_month }, :order => "date desc,id desc")
    
    # build links for the next and previous months
    next_m = (@cur_date >> 1)
    prev_m = (@cur_date << 1)
    @next_link = "/transactions/" + "/" + next_m.strftime("%Y") + "/" + next_m.strftime("%m")
    @prev_link = "/transactions/" + "/" + prev_m.strftime("%Y") + "/" + prev_m.strftime("%m")
    @new_link = "/transactions/new/" + "/" +  @cur_date.strftime("%Y")  + "/" + @cur_date.strftime("%m")

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    @categories = Category.find(:all, :order => :name)

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /transactions/1/edit
  def edit
    @transaction = Transaction.find(params[:id])
    @transaction.amount = sprintf( "%0.02f", @transaction.amount)
    @categories = Category.find(:all, :order => "name")
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /transactions
  def create
    @transaction = Transaction.new(params[:transaction])

    respond_to do |format|
      if @transaction.save
        format.html {
          redirect_to(transactions_url + "/" + @transaction.date.strftime("%Y") + 
              "/" +  @transaction.date.strftime("%m") + "#" + @transaction.id.to_s)
        }
      else
        @categories = Category.find(:all, :order => "name")
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /transactions/1
  def update
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html {
          redirect_to(transactions_url + "/" + @transaction.date.strftime("%Y") + 
              "/" +  @transaction.date.strftime("%m") + "#" + @transaction.id.to_s)
        }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def reconcile
    @id = params[:id]
    @transaction = Transaction.find(@id)
    
    respond_to do |format|
      if @transaction.update_attributes(:reconciled => true)
        format.js { render :template => "/transactions/reconcile.rjs" }
      else
        format.js { render :js => "alert('Failed to reconcile transaction.'); $('#checkbox-#{@id}').prop('checked', !$('#checkbox-#{@id}')[0].checked);" }
      end
    end
  end
  
  def unreconcile
    @id = params[:id]
    @transaction = Transaction.find(@id)
    
    respond_to do |format|
      if @transaction.update_attributes(:reconciled => false)
        format.js { render :template => "/transactions/unreconcile.rjs" }
      else
        format.js { render :js => "alert('Failed to unreconile transaction.'); $('#checkbox-#{@id}').prop('checked', !$('#checkbox-#{@id}')[0].checked);" }
      end
    end
  end

  # DELETE /transactions/1
  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy

    respond_to do |format|
      format.html { 
        redirect_to(transactions_url + "/" + @transaction.date.strftime("%Y") + 
            "/" +  @transaction.date.strftime("%m"))
      }
    end
  end
end
