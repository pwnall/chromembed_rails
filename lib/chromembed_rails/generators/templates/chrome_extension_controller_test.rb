require 'test_helper'

class ChromeExtensionControllerTest < ActionController::TestCase
  test "should get the extension" do
    get :show, :format => 'crx'
  end
  
  test "should get the update file" do
    get :update, :format => 'xml'
  end
end
