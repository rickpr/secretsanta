require 'test_helper'

class SantaControllerTest < ActionController::TestCase
  setup do
    @santum = santa(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:santa)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create santum" do
    assert_difference('Santum.count') do
      post :create, santum: { email: @santum.email, group_id: @santum.group_id, name: @santum.name }
    end

    assert_redirected_to santum_path(assigns(:santum))
  end

  test "should show santum" do
    get :show, id: @santum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @santum
    assert_response :success
  end

  test "should update santum" do
    patch :update, id: @santum, santum: { email: @santum.email, group_id: @santum.group_id, name: @santum.name }
    assert_redirected_to santum_path(assigns(:santum))
  end

  test "should destroy santum" do
    assert_difference('Santum.count', -1) do
      delete :destroy, id: @santum
    end

    assert_redirected_to santa_path
  end
end
