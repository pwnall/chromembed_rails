class CreateChromeExtensionCaches < ActiveRecord::Migration
  def self.up
    create_table :chrome_extension_caches do |t|
      t.string :appid, :length => 128, :null => false
      t.string :version, :length => 64, :null => false
      t.binary :crx_bits, :length => 64.megabytes, :null => false
    end
  end

  def self.down
    drop_table :chrome_extension_caches
  end
end
