# :nodoc: the routes used in all tests
class ActionController::TestCase
  def setup_routes
    @routes = ActionController::Routing::RouteSet.new
    @routes.draw do
      # NOTE: this route should be kept in sync with the generator template.
      chrome_extension
    end
    ApplicationController.send :include, @routes.url_helpers
  end
  
  setup :setup_routes
end
