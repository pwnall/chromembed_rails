require 'chromembed_rails'
require 'rails'

# :nodoc: namespace
module ChromembedRails

class Engine < Rails::Engine
  paths.app                 = "app"
  paths.app.controllers     = "app/controllers"
  paths.app.helpers         = "app/helpers"
  paths.app.models          = "app/models"
  paths.app.views           = "app/views"
  # paths.lib                 = "lib"
  # paths.lib.tasks           = "lib/tasks"
  # paths.config              = "config"
  # paths.config.initializers = "config/initializers"
  # paths.config.locales      = "config/locales"
  # paths.config.routes       = "config/routes.rb"
  
  generators do
    require 'chromembed_rails/generators/all_generator.rb'
  end
end  # class ChromembedRails::Engine

end  # namespace ChromembedRails
