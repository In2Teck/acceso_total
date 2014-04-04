require 'test_helper'

class MailUsersControllerTest < ActionController::TestCase
  setup do
    @mail_user = mail_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mail_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mail_user" do
    assert_difference('MailUser.count') do
      post :create, mail_user: { email: @mail_user.email, name: @mail_user.name }
    end

    assert_redirected_to mail_user_path(assigns(:mail_user))
  end

  test "should show mail_user" do
    get :show, id: @mail_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mail_user
    assert_response :success
  end

  test "should update mail_user" do
    put :update, id: @mail_user, mail_user: { email: @mail_user.email, name: @mail_user.name }
    assert_redirected_to mail_user_path(assigns(:mail_user))
  end

  test "should destroy mail_user" do
    assert_difference('MailUser.count', -1) do
      delete :destroy, id: @mail_user
    end

    assert_redirected_to mail_users_path
  end
end
