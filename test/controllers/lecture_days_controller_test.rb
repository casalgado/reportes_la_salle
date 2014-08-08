require 'test_helper'

class LectureDaysControllerTest < ActionController::TestCase
  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

end
