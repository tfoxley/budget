class AccountsController < ApplicationController
  before_filter :authorize
  
  # GET /accounts
  def index
    @accounts = Account.find(:all, :order => "name")

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /accounts/new
  def new
    @account = Account.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /accounts/1/edit
  def edit
    @account = Account.find(params[:id])
  end

  # POST /accounts
  def create
    @account = Account.new(params[:account])

    respond_to do |format|
      if @account.save
        format.html { redirect_to(accounts_url, :notice => 'Account was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /accounts/1
  def update
    @account = Account.find(params[:id])

    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to(accounts_url, :notice => 'Account was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /accounts/1
  def destroy
    @account = Account.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to(accounts_url) }
    end
  end
end
