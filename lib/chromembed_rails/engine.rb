require 'chromembed_rails'
require 'rails'

# :nodoc: namespace
module ChromembedRails

class Engine < Rails::Engine
  generators do
    require 'chromembed_rails/generators/all_generator.rb'
  end
end  # class ChromembedRails::Engine

end  # namespace ChromembedRails
