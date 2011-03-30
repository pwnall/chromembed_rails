ActiveRecord::Base.establish_connection :adapter => 'sqlite3',
                                        :database => ':memory:'
ActiveRecord::Base.configurations = true

ActiveRecord::Migration.verbose = false
require 'chromembed_rails/generators/templates/001_create_chrome_extension_caches.rb'
CreateChromeExtensionCaches.up

require 'chromembed_rails/generators/templates/chrome_extension_cache.rb'

# :nodoc: open TestCase to setup fixtures
class ActiveSupport::TestCase
  include ActiveRecord::TestFixtures
  
  self.fixture_path =
      File.expand_path '../../../lib/chromembed_rails/generators/templates',
                       __FILE__
  
  self.use_transactional_fixtures = false
  self.use_instantiated_fixtures  = false
  self.pre_loaded_fixtures = false
  fixtures :all
end
