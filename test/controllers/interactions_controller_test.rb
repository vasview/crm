require 'test_helper'

class InteractionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get interactions_new_url
    assert_response :success
  end

  test "should get create" do
    get interactions_create_url
    assert_response :success
  end

  test "should get show" do
    get interactions_show_url
    assert_response :success
  end

end
