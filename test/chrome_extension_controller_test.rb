require File.expand_path('../test_helper', __FILE__)

require 'chromembed_rails/generators/templates/chrome_extension_controller.rb'

# Run the tests in the generator, to make sure they pass.
require 'chromembed_rails/generators/templates/chrome_extension_controller_test.rb'

# Tests the methods injected by config_vars_controller.
class ChromeExtensionControllerExtendedTest < ActionController::TestCase
  tests ChromeExtensionController

  test "should get the extension" do
    get :show, :format => 'crx'
    assert_response :success
    assert_equal 'Cr24', response.body[0, 4]
    assert response.body.include?("PK\x03\x04"), 'crx does not contain a ZIP'
  end
  
  test "should get the update file" do
    get :update, :format => 'xml'
    assert_response :success
    assert_select 'gupdate' do
      assert_select "app[appid=mmdhdbifokakcihplakafeifahobiijk]" do
        assert_select 'updatecheck[codebase=http://test.host/chrome_extension.crx][version=1.0.0]'
      end
    end
  end
end
