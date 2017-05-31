require 'test_helper'

class UserShowEditControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_show_edit_new_url
    assert_response :success
  end

  test "should get show" do
    get user_show_edit_show_url
    assert_response :success
  end

  test "should get create" do
    get user_show_edit_create_url
    assert_response :success
  end

  test "should get update" do
    get user_show_edit_update_url
    assert_response :success
  end

  test "should get delete" do
    get user_show_edit_delete_url
    assert_response :success
  end

end
