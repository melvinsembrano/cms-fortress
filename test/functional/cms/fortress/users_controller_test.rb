require 'test_helper'

class Cms::Fortress::UsersControllerTest < ActionController::TestCase
  setup do
    @cms_fortress_user = cms_fortress_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cms_fortress_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cms_fortress_user" do
    assert_difference('Cms::Fortress::User.count') do
      post :create, cms_fortress_user: { email: @cms_fortress_user.email, password: @cms_fortress_user.password, password_confirmation: @cms_fortress_user.password_confirmation }
    end

    assert_redirected_to cms_fortress_user_path(assigns(:cms_fortress_user))
  end

  test "should show cms_fortress_user" do
    get :show, id: @cms_fortress_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cms_fortress_user
    assert_response :success
  end

  test "should update cms_fortress_user" do
    put :update, id: @cms_fortress_user, cms_fortress_user: { email: @cms_fortress_user.email, password: @cms_fortress_user.password, password_confirmation: @cms_fortress_user.password_confirmation }
    assert_redirected_to cms_fortress_user_path(assigns(:cms_fortress_user))
  end

  test "should destroy cms_fortress_user" do
    assert_difference('Cms::Fortress::User.count', -1) do
      delete :destroy, id: @cms_fortress_user
    end

    assert_redirected_to cms_fortress_users_path
  end
end
