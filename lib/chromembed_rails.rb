# :nodoc: namespace
module ChromembedRails
  class <<self
    # Path to the extension code.
    #
    # This should be set in an initializer.
    attr_accessor :extension_path
  
    # Path to the private key used to the sign the extension.
    #
    # This should be set in an initializer.
    attr_accessor :key_path
  end
end

require 'chromembed_rails/controller.rb'
require 'chromembed_rails/model.rb'
require 'chromembed_rails/routes.rb'

if defined?(Rails)
  require 'chromembed_rails/engine.rb'
end
