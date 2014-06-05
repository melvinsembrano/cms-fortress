# http://api.rubyonrails.org/classes/ActionDispatch/IntegrationTest.html
require 'test_helper'

class Cms::Fortress::UsersControllerIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @comfy_cms_site = comfy_cms_sites(:default)
  end

  test "it should redirect to login if unauthenticated" do
    get "/cms-admin/"
    follow_redirect!
    follow_redirect!
    assert_equal 200, status
    assert_equal "/cms-admin/login", path
  end
end
