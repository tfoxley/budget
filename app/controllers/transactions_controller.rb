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
    @current_balance = 0.0
    @transactions.each { |x| @current_balance += x.amount unless x.amount.blank? }
    
    # build links for the next and previous months
    next_m = (@cur_date >> 1)
    prev_m = (@cur_date << 1)
    @next_link = "/transactions/" + next_m.strftime("%Y") + "/" + next_m.strftime("%m")
    @prev_link = "/transactions/" + prev_m.strftime("%Y") + "/" + prev_m.strftime("%m")
    @new_link = "/transactions/new/" +  @cur_date.strftime("%Y")  + "/" + @cur_date.strftime("%m")

    respond_to do |format|
      format.html # index.html.erb
      format.mobile
    end
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    @categories = Category.find(:all, :order => "name")
    @accounts = Account.find(:all, :order => "name")
    @default_account = @accounts.select {|a| a.default}.first

    respond_to do |format|
      format.html # new.html.erb
      format.mobile
    end
  end

  # GET /transactions/1/edit
  def edit
    @transaction = Transaction.find(params[:id])
    @transaction.amount = sprintf( "%0.02f", @transaction.amount)
    @categories = Category.find(:all, :order => "name")
    @accounts = Account.find(:all, :order => "name")
    
    respond_to do |format|
      format.html # new.html.erb
      format.mobile
    end
  end

  # POST /transactions
  def create
    @transaction = Transaction.new(params[:transaction])
    
    # Update account balance
    account = Account.find(@transaction.account_id)
    account.actual_balance = account.actual_balance - @transaction.amount
    account.reconciled_balance = account.reconciled_balance - @transaction.amount if @transaction.reconciled
    account.save

    respond_to do |format|
      if @transaction.save
        format.html {
          redirect_to(transactions_url + "/" + @transaction.date.strftime("%Y") + 
              "/" + @transaction.date.strftime("%m") + "#" + @transaction.id.to_s)
        }
        format.mobile {
          redirect_to(transactions_url + "/" + @transaction.date.strftime("%Y") + 
              "/" + @transaction.date.strftime("%m") + "#" + @transaction.id.to_s)
        }
      else
        @categories = Category.find(:all, :order => "name")
        format.html { render :action => "new" }
        format.mobile { render :action => "new" }
      end
    end
  end

  # PUT /transactions/1
  def update
    @transaction = Transaction.find(params[:id])
    
    # Update account balance
    prev_account = Account.find(@transaction.account_id)
    new_account = Account.find(params[:account_id])
    prev_account.actual_balance = prev_account.actual_balance + @transaction.amount
    new_account.actual_balance = new_account.actual_balance - params[:amount]
    if @transaction.reconciled
      prev_account.reconciled_balance = prev_account.reconciled_balance + @transaction.amount
      new_account.reconciled_balance = new_account.reconciled_balance - params[:amount]
    end
    prev_account.save
    new_account.save

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html {
          redirect_to(transactions_url + "/" + @transaction.date.strftime("%Y") + 
              "/" + @transaction.date.strftime("%m") + "#" + @transaction.id.to_s)
        }
        format.mobile {
          redirect_to(transactions_url + "/" + @transaction.date.strftime("%Y") + 
              "/" + @transaction.date.strftime("%m") + "#" + @transaction.id.to_s)
        }
      else
        format.html { render :action => "edit" }
        format.mobile { render :action => "edit" }
      end
    end
  end
  
  def reconcile
    @id = params[:id]
    @transaction = Transaction.find(@id)
    
    # Update account balance
    account = Account.find(@transaction.account_id)
    account.reconciled_balance = account.reconciled_balance - @transaction.amount
    account.save
    
    respond_to do |format|
      if @transaction.update_attributes(:reconciled => true)
        format.js { render :js => "$('##{@id}').effect('highlight', {'color':'#aaa'}, 3000); $('##{@id} input').attr('data-action', 'unreconcile');" }
      else
        format.js { render :js => "alert('Failed to reconcile transaction.'); $('#checkbox-#{@id}').prop('checked', !$('#checkbox-#{@id}')[0].checked);" }
      end
    end
  end
  
  def unreconcile
    @id = params[:id]
    @transaction = Transaction.find(@id)
    
    # Update account balance
    account = Account.find(@transaction.account_id)
    account.reconciled_balance = account.reconciled_balance + @transaction.amount
    account.save
    
    respond_to do |format|
      if @transaction.update_attributes(:reconciled => false)
        format.js { render :js => "$('##{@id}').effect('highlight', {'color':'#aaa'}, 3000); $('##{@id} input').attr('data-action', 'reconcile');" }
      else
        format.js { render :js => "alert('Failed to unreconile transaction.'); $('#checkbox-#{@id}').prop('checked', !$('#checkbox-#{@id}')[0].checked);" }
      end
    end
  end

  # DELETE /transactions/1
  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    
    # Update account balance
    account = Account.find(@transaction.account_id)
    account.actual_balance = account.actual_balance + @transaction.amount
    if @transaction.reconciled
      account.reconciled_balance = account.reconciled_balance + @transaction.amount
    end
    account.save

    respond_to do |format|
      format.html { redirect_to(transactions_url) }
      format.mobile { redirect_to(transactions_url) }
    end
  end
end
