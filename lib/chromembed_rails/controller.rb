require 'action_controller'
require 'crxmake'

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
  def chrome_extension_controller
    include ControllerInstanceMethods
  end
end

# Included in controllers that call config_vars_controller.
module ControllerInstanceMethods
  # GET /chrome_extension.crx
  def show
    extension_data =
        ChromeExtensionCache.extension_data(chrome_extension_update_url)
    send_data extension_data.crx_bits, :disposition => 'attachment',
        :content_type => 'application/x-chrome-extension'
  end

  # GET /chrome_extension/update.xml
  def update
    extension_data =
        ChromeExtensionCache.extension_data(chrome_extension_update_url)
    render :text => update_xml(extension_data)
  end
  
  # Contents of the update XML document for an extension.
  def update_xml(extension_data)
    <<END_XML
<?xml version='1.0' encoding='UTF-8'?>
<gupdate xmlns='http://www.google.com/update2/response' protocol='2.0'>
  <app appid='#{extension_data.appid}'>
    <updatecheck codebase='#{chrome_extension_url}' version='#{extension_data.version}' />
  </app>
</gupdate>
END_XML
  end
  private :update_xml
end  # module ChromembedRails::Session::ControllerInstanceMethods

ActionController::Base.send :include, ControllerMixin

end  # namespace ChromembedRails::Session

end  # namespace ChromembedRails
