require 'action_controller'

# :nodoc: namespace
module ChromembedRails

# :nodoc: namespace
module Session

# Mixed into ActiveController::Base
module ControllerMixin
  def self.included(base)
    base.send :extend, ControllerClassMethods
  end
end

# Methods here become ActiveController::Base class methods.
module ControllerClassMethods  
  # Turns the current controller into the Chrome extension serving controller.
  #
  # Right now, this should be called from ChromeExtensionController. The
  # controller name is hardwired in other parts of the implementation.
  def chrome_embed_controller
    include ControllerInstanceMethods
  end
end

# Included in controllers that call config_vars_controller.
module ControllerInstanceMethods
  # GET /chrome_extension.crx
  def show
    edit
    render :text => @config_var.value
  end

  # GET /chrome_extension/update.xml
  def update
  end
end  # module ChromembedRails::Session::ControllerInstanceMethods

ActionController::Base.send :include, ControllerMixin

end  # namespace ChromembedRails::Session

end  # namespace ChromembedRails
