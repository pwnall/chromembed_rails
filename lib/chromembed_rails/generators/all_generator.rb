require 'openssl'

require 'rails'

# :nodoc: namespace
module ChromembedRails

# Name chosen to get chromembed_rails:all
class AllGenerator < Rails::Generators::Base
  source_root File.expand_path("../templates", __FILE__)

  def create_chrome_extension
    copy_file 'chrome_extension_cache.rb',
              File.join('app', 'models', 'chrome_extension_cache.rb')
    copy_file '001_create_chrome_extension_caches.rb', File.join('db',
        'migrate', '20110330000001_create_chrome_extension_caches.rb')
    copy_file 'chrome_extension_caches.yml',
              File.join('test', 'fixtures', 'chrome_extension_caches.yml')
    
    copy_file 'chrome_extension_controller.rb',
              File.join('app', 'controllers', 'chrome_extension_controller.rb')
    copy_file File.join('chrome_extension_controller_test.rb'),
        File.join('test', 'functional', 'chrome_extension_controller_test.rb')
    route 'chrome_extension'
    
    copy_file 'chrome_extension_initializer.rb',
              File.join('config', 'initializers', 'chrome_extension.rb')
              
    copy_file File.join('desktop', 'chrome_extension', 'manifest.json'),
              File.join('desktop', 'chrome_extension', 'manifest.json')
    ['ruby16.png', 'ruby19.png', 'ruby128.png'].each do |view_name|
      copy_file File.join('desktop', 'chrome_extension', 'images', view_name),
                File.join('desktop', 'chrome_extension', 'images', view_name)
    end
    template File.join('desktop', 'chrome_extension.pem.erb'),
              File.join('desktop', 'chrome_extension.pem')
  end
end  # class ChromembedRails::ConfigVarsGenerator

end  # namespace ChromembedRails
