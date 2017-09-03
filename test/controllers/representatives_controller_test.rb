require 'test_helper'

class RepresentativesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get representatives_index_url
    assert_response :success
  end

  test "should get show" do
    get representatives_show_url
    assert_response :success
  end

  test "should get create" do
    get representatives_create_url
    assert_response :success
  end

  test "should get edit" do
    get representatives_edit_url
    assert_response :success
  end

  test "should get update" do
    get representatives_update_url
    assert_response :success
  end

  test "should get destroy" do
    get representatives_destroy_url
    assert_response :success
  end

end
