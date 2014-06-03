# http://api.rubyonrails.org/classes/ActionDispatch/IntegrationTest.html
require 'test_helper'

class Cms::Fortress::UsersControllerIntegrationTest < ActionDispatch::IntegrationTest
  test "it_should_get_index" do
    get "/cms-admin/"
    assert_equal 200, status
  end
end
