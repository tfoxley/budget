require 'test_helper'

class TransactionTypesControllerTest < ActionController::TestCase
  setup do
    @transaction_type = transaction_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transaction_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transaction_type" do
    assert_difference('TransactionType.count') do
      post :create, :transaction_type => @transaction_type.attributes
    end

    assert_redirected_to transaction_type_path(assigns(:transaction_type))
  end

  test "should show transaction_type" do
    get :show, :id => @transaction_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @transaction_type.to_param
    assert_response :success
  end

  test "should update transaction_type" do
    put :update, :id => @transaction_type.to_param, :transaction_type => @transaction_type.attributes
    assert_redirected_to transaction_type_path(assigns(:transaction_type))
  end

  test "should destroy transaction_type" do
    assert_difference('TransactionType.count', -1) do
      delete :destroy, :id => @transaction_type.to_param
    end

    assert_redirected_to transaction_types_path
  end
end
