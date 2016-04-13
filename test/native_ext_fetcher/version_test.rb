require 'test_helper'

class VersionTest < Minitest::Test
  test 'defines version' do
    refute_nil NativeExtFetcher::VERSION
  end
end
