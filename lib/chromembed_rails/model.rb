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

    extend ModelMetaclassMethods
    include ModelInstanceMethods
  end
end  # module ChromembedRails::Model::ModelClassMethods


# Included in the metaclass of models that call chrome_extension_cache_model.
module ModelMetaclassMethods
  # ChromeExtensionCache entry for the latest extension bits.
  def extension_data
    self.new.update_with_current_bits
  end

  # Path to the extension files.
  def extension_path
    Rails.root.join 'desktop', 'chrome_extension'
  end
  
  # Path to the private key used to sign the extension.
  def key_path
    Rails.root.join 'desktop', 'chrome_extension.pem'
  end
end  # module ChromembedRails::Model::ModelMetaclassMethods


# Included in models that call chrome_extension_cache_model.
module ModelInstanceMethods
  def update_with_current_bits
    extension_path = self.class.extension_path
    manifest_path = File.join extension_path, 'manifest.json'
    manifest_json = ActiveSupport::JSON.decode File.read(manifest_path)
    self.version = manifest_json['version']

    key_path = self.class.key_path
    key = OpenSSL::PKey::RSA.new File.read(key_path)
    # Source: http://supercollider.dk/2010/01/calculating-chrome-extension-id-from-your-private-key-233
    alg = ["30819F300D06092A864886F70D010101050003818D00"].pack('H*')
    hash = Digest::SHA256.hexdigest(alg + key.public_key.to_der)[0...32]
    self.appid = hash.unpack('C*').map{ |c| c < 97 ? c + 49 : c + 10 }.
                      pack('C*')
    
    crx_path = Rails.root.join 'tmp', 'chrome_extension.crx'
    CrxMake.make :ex_dir => extension_path, :pkey => key_path,
        :crx_output => crx_path, :verbose => true
    self.crx_bits = File.read crx_path
    # File.unlink crx_path
    
    self
  end
end  # module ChromembedRails::Model::ModelInstanceMethods

ActiveRecord::Base.send :include, ModelMixin

end  # namespace ChromembedRails::Model

end  # namespace ChromembedRails
