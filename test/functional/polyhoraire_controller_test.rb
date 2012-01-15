require 'test_helper'

class PolyhoraireControllerTest < ActionController::TestCase
  test "should get connect" do
    get :connect
    assert_response :success
  end

  test "should get export" do
    get :export
    assert_response :success
  end

  test "should get results" do
    get :results
    assert_response :success
  end

end
