# Mock Rails.root used in the chrome_extension initializer.
module Rails
  def self.root
    Pathname.new File.expand_path(
        '../../../lib/chromembed_rails/generators/templates', __FILE__)
  end
end
require 'chromembed_rails/generators/templates/chrome_extension_initializer.rb'

# Point to the testing key.
ChromembedRails.key_path = File.expand_path '../chrome_extension.pem', __FILE__
