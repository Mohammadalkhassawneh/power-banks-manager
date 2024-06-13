require "test_helper"

class RailsControllerTest < ActionDispatch::IntegrationTest
  test "should get server" do
    get rails_server_url
    assert_response :success
  end
end
