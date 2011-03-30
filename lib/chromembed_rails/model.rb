require 'English'

require 'active_record'

# :nodoc: namespace
module ChromembedRails

# :nodoc: namespace
module Model


# Mixed into ActiveRecord::Base
module ModelMixin
  def self.included(base)
    base.send :extend, ModelClassMethods
  end
end


# Methods here become ActiveRecord::Base class methods.
module ModelClassMethods
  # Extends the model to cache data for serving an embedded Chrome extension.
  def chrome_extension_cache_model
    # The extension's appid.
    validates :appid, :uniqueness => true, :length => 1..128, :presence => true
  
    # The extension version listed in manifest.json.
    validates :version, :length => { :in => 0..64, :allow_nil => false }
    
    # The CRX file contents.
    validates :crx_bits,
              :length => { :in => 0..(64.megabytes), :allow_nil => false }

    extend ModelMetaclassMethods
    include ModelInstanceMethods
  end
end  # module ChromembedRails::Model::ModelClassMethods


# Included in the metaclass of models that call chrome_extension_cache_model.
module ModelMetaclassMethods
  # ChromeExtensionCache entry for the latest extension bits.
  def extension_data(chrome_extension_update_url)
    self.new.update_with_current_bits(
        'update_url' => chrome_extension_update_url)
  end
end  # module ChromembedRails::Model::ModelMetaclassMethods


# Included in models that call chrome_extension_cache_model.
module ModelInstanceMethods
  # Updates this cache entry to reflect the current extension code.
  #
  # Args:
  #   manifest_changes:: hash to be merged into the extension's manifest JSON;
  #                      'update_url' and 'version' might be good keys to change
  def update_with_current_bits(manifest_changes)
    extension_path = ChromembedRails.extension_path
    manifest_path = File.join extension_path, 'manifest.json'
    manifest_json = ActiveSupport::JSON.decode File.read(manifest_path)
    manifest_json.merge! manifest_changes
    self.version = manifest_json['version']

    key_path = ChromembedRails.key_path
    key = OpenSSL::PKey::RSA.new File.read(key_path)
    # Source: http://supercollider.dk/2010/01/calculating-chrome-extension-id-from-your-private-key-233
    alg = ["30819F300D06092A864886F70D010101050003818D00"].pack('H*')
    hash = Digest::SHA256.hexdigest(alg + key.public_key.to_der)[0...32]
    self.appid = hash.unpack('C*').map{ |c| c < 97 ? c + 49 : c + 10 }.
                      pack('C*')
    
    tmp_path = Rails.root.join 'tmp', "chrome_ext_#{Time.now.to_f}_#{$PID}"
    ext_path = File.join tmp_path, 'chrome_extension'
    FileUtils.mkdir_p ext_path
    FileUtils.cp_r File.join(extension_path, '.'), ext_path
    man_path = File.join ext_path, 'manifest.json'
    File.open(man_path, 'wb') do |f|
      f.write ActiveSupport::JSON.encode manifest_json
    end
    
    crx_path = File.join tmp_path, 'chrome_extension.crx'
    CrxMake.make :ex_dir => ext_path, :pkey => key_path,
                 :crx_output => crx_path, :verbose => false
    self.crx_bits = File.read crx_path
    FileUtils.rm_r tmp_path
    
    self
  end
end  # module ChromembedRails::Model::ModelInstanceMethods

ActiveRecord::Base.send :include, ModelMixin

end  # namespace ChromembedRails::Model

end  # namespace ChromembedRails
