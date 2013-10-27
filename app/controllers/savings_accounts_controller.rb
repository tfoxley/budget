class SavingsAccountsController < ApplicationController
  before_filter :authorize
  
  # GET /savings_accounts
  def index
    @savings_accounts = SavingsAccount.find(:all, :order => 'name')
    @total = 0.0
    @savings_accounts.each { |x| @total += x.amount unless x.amount.blank? }

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /savings_accounts/new
  def new
    @savings_account = SavingsAccount.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /savings_accounts
  def create
    @savings_account = SavingsAccount.new(params[:savings_account])

    respond_to do |format|
      if @savings_account.save
        format.html { redirect_to(savings_accounts_url) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # POST /savings_accounts/add_subtract
  def add_subtract
    puts params
    @savings_account = SavingsAccount.find(params[:id])
    
    adjustment = params[:adjustment].to_f
    adjustment = adjustment * -1 if params[:add_or_subtract] == "subtract"
    
    @savings_account.amount = @savings_account.amount + adjustment
    
    respond_to do |format|
      if @savings_account.save
        @savings_accounts = SavingsAccount.all
        @total = 0.0
        @savings_accounts.each { |x| @total += x.amount unless x.amount.blank? }
        format.js { render :template => "/savings_accounts/add_subtract.rjs" }
      end
    end
  end

  # POST /savings_accounts/add_subtract_form/1
  def add_subtract_form
    @savings_account = SavingsAccount.find(params[:id])
    respond_to do |format|
      unless @savings_account.blank?
        format.js { render :template => "/savings_accounts/add_subtract_form.rjs" }
      end
    end
  end

  # DELETE /savings_accounts/1
  def destroy
    @savings_account = SavingsAccount.find(params[:id])
    @savings_account.destroy

    respond_to do |format|
      format.js { render :template => "/savings_accounts/quick_delete.rjs" }
      format.html { redirect_to('/savings_accounts', :notice => 'List item was successfully deleted.') }
    end
  end
end
