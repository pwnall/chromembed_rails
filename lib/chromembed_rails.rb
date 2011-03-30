# :nodoc: namespace
module ChromembedRails
end

require 'chromembed_rails/controller.rb'
require 'chromembed_rails/model.rb'
require 'chromembed_rails/routes.rb'

if defined?(Rails)
  require 'chromembed_rails/engine.rb'
end
