require File.expand_path('../test_helper', __FILE__)

require 'chromembed_rails/generators/templates/chrome_extension_controller.rb'

# Run the tests in the generator, to make sure they pass.
require 'chromembed_rails/generators/templates/chrome_extension_controller_test.rb'

# Tests the methods injected by config_vars_controller.
class ChromeExtensionControllerExtendedTest < ActionController::TestCase
  tests ChromeExtensionController

  setup do
  end

  test "write something here" do
    assert true
  end
end
