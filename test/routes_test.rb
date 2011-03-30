require File.expand_path('../test_helper', __FILE__)

require 'chromembed_rails/generators/templates/chrome_extension_controller.rb'


class RoutesTest < ActionController::TestCase
  tests ChromeExtensionController

  test "chrome_extension routes" do
    assert_routing({:path => "/chrome_extension.crx", :method => :get},
                   {:controller => 'chrome_extension', :action => 'show'})
    assert_routing({:path => "/chrome_extension/update.xml", :method => :get},
                   {:controller => 'chrome_extension', :action => 'update'})
  end
end
