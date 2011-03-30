require 'test_helper'

class ChromeExtensionControllerTest < ActionController::TestCase
  test "should get the extension" do
    get :show, :format => 'crx'
    assert_response :success
  end
  
  test "should get the update file" do
    get :update, :format => 'xml'
    assert_response :success
  end
end
