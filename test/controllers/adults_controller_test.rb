require 'test_helper'

class AdultsControllerTest < ActionController::TestCase
  setup do
    @adult = adults(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:adults)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create adult" do
    assert_difference('Adult.count') do
      post :create, adult: { email: @adult.email, first: @adult.first, last: @adult.last }
    end

    assert_redirected_to adult_path(assigns(:adult))
  end

  test "should show adult" do
    get :show, id: @adult
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @adult
    assert_response :success
  end

  test "should update adult" do
    patch :update, id: @adult, adult: { email: @adult.email, first: @adult.first, last: @adult.last }
    assert_redirected_to adult_path(assigns(:adult))
  end

  test "should destroy adult" do
    assert_difference('Adult.count', -1) do
      delete :destroy, id: @adult
    end

    assert_redirected_to adults_path
  end
end
