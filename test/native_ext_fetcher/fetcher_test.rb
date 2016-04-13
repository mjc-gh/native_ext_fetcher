require 'test_helper'

class FetcherTest < Minitest::Test
  setup do
    FakeFS.activate!
    FileUtils.mkdir_p File.join(__dir__, '..', '..', 'lib')

    @fetch = NativeExtFetcher::Fetcher.new
    @fetch.config 'host.com', __dir__, linux_x86_64: 'abcdef'
  end

  teardown do
    FakeFS.deactivate!
  end

  test 'download_path exists' do
    assert Dir.exists?(@fetch.download_path)
  end
end
