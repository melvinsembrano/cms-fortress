# http://api.rubyonrails.org/classes/ActionController/TestCase.html
require 'test_helper'


class Cms::Fortress::RolesControllerTest < ActionController::TestCase
  def setup
    @comfy_cms_site = comfy_cms_sites(:default)
    @cms_fortress_user = cms_fortress_users(:one)
    @cms_fortress_role = cms_fortress_roles(:one)
    sign_in Cms::Fortress::User, @cms_fortress_user
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:cms_fortress_roles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cms_fortress_role" do
    assert_difference('Cms::Fortress::Role.count') do
      post :create, cms_fortress_role: { description: @cms_fortress_role.description, name: @cms_fortress_role.name }
    end

    assert_redirected_to cms_fortress_role_path(assigns(:cms_fortress_role))
  end

  test "should show cms_fortress_role" do
    get :show, id: @cms_fortress_role
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cms_fortress_role
    assert_response :success
  end

  test "should update cms_fortress_role" do
    put :update, id: @cms_fortress_role, cms_fortress_role: { description: @cms_fortress_role.description, name: @cms_fortress_role.name }
    assert_redirected_to cms_fortress_role_path(assigns(:cms_fortress_role))
  end

  test "should destroy cms_fortress_role" do
    assert_difference('Cms::Fortress::Role.count', -1) do
      delete :destroy, id: @cms_fortress_role
    end

    assert_redirected_to cms_fortress_roles_path
  end
end
