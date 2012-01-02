require 'test_helper'

class SavingsAccountsControllerTest < ActionController::TestCase
  setup do
    @savings_account = savings_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:savings_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create savings_account" do
    assert_difference('SavingsAccount.count') do
      post :create, :savings_account => @savings_account.attributes
    end

    assert_redirected_to savings_account_path(assigns(:savings_account))
  end

  test "should show savings_account" do
    get :show, :id => @savings_account.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @savings_account.to_param
    assert_response :success
  end

  test "should update savings_account" do
    put :update, :id => @savings_account.to_param, :savings_account => @savings_account.attributes
    assert_redirected_to savings_account_path(assigns(:savings_account))
  end

  test "should destroy savings_account" do
    assert_difference('SavingsAccount.count', -1) do
      delete :destroy, :id => @savings_account.to_param
    end

    assert_redirected_to savings_accounts_path
  end
end
