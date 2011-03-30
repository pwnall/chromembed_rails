require File.expand_path('../test_helper', __FILE__)

class ChromeExtensionCacheTest < ActiveSupport::TestCase
  def setup
    @entry = ChromeExtensionCache.new :appid => 'aabbcc', :version => '1.0.0',
         :crx_bits => 'abcd' * 16
  end
  
  test "setup" do
    assert @entry.valid?
  end
  
  test "update_with_current_bits" do
    @entry.update_with_current_bits 'update_url' => 'http://url/update.xml'
    
    assert_equal 'mmdhdbifokakcihplakafeifahobiijk', @entry.appid
    assert_equal '1.0.0', @entry.version
    assert_equal 'Cr24', @entry.crx_bits[0, 4]
    
    assert @entry.crx_bits.include?("PK\x03\x04"), 'crx does not contain a ZIP'
    assert @entry.crx_bits.length > 1.kilobyte, 'crx file is very small'
  end
end
