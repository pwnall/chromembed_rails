require 'action_pack'

# :nodoc: namespace
module ChromembedRails

# :nodoc: namespace
module Routes

# :nodoc: mixed into ActionPack's route mapper.
module MapperMixin
  def chromembed_rails
    get 'chrome_extension.crx' => 'chrom_embed#show', :as => :chrome_extension
    get 'chrome_extension/update.xml' => 'chrom_embed#update',
        :as => :chrome_extension_update
  end
end

ActionDispatch::Routing::Mapper.send :include, MapperMixin

end  # namespace ChromembedRails::Routes

end  # namespace ChromembedRails
