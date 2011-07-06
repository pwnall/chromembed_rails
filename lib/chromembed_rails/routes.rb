require 'action_pack'

# :nodoc: adding the chrome_extension method to the route mapper.
class ActionDispatch::Routing::Mapper
  # Installs the routes for serving an extension
  def chrome_extension
    get 'chrome_extension.crx' => 'chrome_extension#show',
        :as => :chrome_extension
    get 'chrome_extension/update.xml' => 'chrome_extension#update',
        :as => :chrome_extension_update
  end
end
