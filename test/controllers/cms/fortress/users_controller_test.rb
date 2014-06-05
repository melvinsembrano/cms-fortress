# http://api.rubyonrails.org/classes/ActionController/TestCase.html
require 'test_helper'

class Cms::Fortress::UsersControllerTest < ActionController::TestCase
  def setup
    @comfy_cms_site = comfy_cms_sites(:default)
    @cms_fortress_user = cms_fortress_users(:one)
    @cms_fortress_role_details = cms_fortress_role_details(:one)
    sign_in Cms::Fortress::User, @cms_fortress_user
  end

  def test_it_should_get_index
    get :index
    assert_not_nil assigns(:cms_fortress_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cms_fortress_user" do
    assert_difference('Cms::Fortress::User.count') do
      post :create, cms_fortress_user: { email: 'foo@bar.com', password: 'foobar123', password_confirmation: 'foobar123' }
    end

    assert_redirected_to cms_fortress_users_path
  end

  test "should get edit" do
    get :edit, id: @cms_fortress_user
    assert_response :success
  end

  test "should update cms_fortress_user" do
    put :update, id: @cms_fortress_user, cms_fortress_user: { email: @cms_fortress_user.email, password: @cms_fortress_user.password, password_confirmation: @cms_fortress_user.password_confirmation }
    #assert_redirected_to cms_fortress_user_path(assigns(:cms_fortress_user))
    assert_redirected_to cms_fortress_users_path()
  end

  test "should destroy cms_fortress_user" do
    assert_difference('Cms::Fortress::User.count', -1) do
      delete :destroy, id: @cms_fortress_user
    end

    assert_redirected_to cms_fortress_users_path
  end
end
