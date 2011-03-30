class CreateChromeExtensionCaches < ActiveRecord::Migration
  def self.up
    create_table :chrome_extension_caches do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :chrome_extension_caches
  end
end
