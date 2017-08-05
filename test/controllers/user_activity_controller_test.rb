require 'test_helper'

class UserActivityControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_activity_index_url
    assert_response :success
  end

end
