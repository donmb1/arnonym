require 'test_helper'

class PollsControllerTest < ActionController::TestCase
  setup do
    @poll = polls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:polls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create poll" do
    assert_difference('Poll.count') do
      post :create, poll: { category: @poll.category, code: @poll.code, description: @poll.description, key_admin_hash: @poll.key_admin_hash, key_admin_salt: @poll.key_admin_salt, key_user_hash: @poll.key_user_hash, key_user_salt: @poll.key_user_salt, name: @poll.name, pageviews: @poll.pageviews }
    end

    assert_redirected_to poll_path(assigns(:poll))
  end

  test "should show poll" do
    get :show, id: @poll
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @poll
    assert_response :success
  end

  test "should update poll" do
    patch :update, id: @poll, poll: { category: @poll.category, code: @poll.code, description: @poll.description, key_admin_hash: @poll.key_admin_hash, key_admin_salt: @poll.key_admin_salt, key_user_hash: @poll.key_user_hash, key_user_salt: @poll.key_user_salt, name: @poll.name, pageviews: @poll.pageviews }
    assert_redirected_to poll_path(assigns(:poll))
  end

  test "should destroy poll" do
    assert_difference('Poll.count', -1) do
      delete :destroy, id: @poll
    end

    assert_redirected_to polls_path
  end
end
