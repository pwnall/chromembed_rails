require 'action_controller'
require 'crxmake'

# :nodoc: namespace
module ChromembedRails

# Included in the Chrome extension serving controller.
#
# Some parts of the codebase assume that the controller's name is
# ChromeExtension.
module Controller
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
    <updatecheck codebase='#{url_for(:action => :show)}' version='#{extension_data.version}' />
  </app>
</gupdate>
END_XML
  end
  private :update_xml
end  # module ChromembedRails::Controller

end  # namespace ChromembedRails
