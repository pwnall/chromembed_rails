require File.expand_path('../test_helper', __FILE__)

class ChromeExtensionCacheTest < ActiveSupport::TestCase
  def setup
    @entry = ChromeExtensionCache.new :appid => 'aabbcc', :version => '1.0.0',
         :crx_bits => 'abcd' * 16
  end
  
  test "setup" do
    assert @entry.valid?
  end
end
