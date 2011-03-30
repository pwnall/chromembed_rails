require 'action_pack'

# :nodoc: namespace
module ChromembedRails

# :nodoc: namespace
module Routes

# :nodoc: mixed into ActionPack's route mapper.
module MapperMixin
  def chrome_extension
    get 'chrome_extension.crx' => 'chrome_extension#show',
        :as => :chrome_extension
    get 'chrome_extension/update.xml' => 'chrome_extension#update',
        :as => :chrome_extension_update
  end
end

ActionDispatch::Routing::Mapper.send :include, MapperMixin

end  # namespace ChromembedRails::Routes

end  # namespace ChromembedRails
