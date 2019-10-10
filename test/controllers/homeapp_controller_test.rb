require 'test_helper'

class HomeappControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get homeapp_index_url
    assert_response :success
  end

end
