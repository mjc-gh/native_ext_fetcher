require 'test_helper'

class PlatformTest < Minitest::Test
  test 'defines HOST_OS' do
    refute_nil NativeExtFetcher::Platform::HOST_OS
  end

  test 'defines HOST_ARCH' do
    refute_nil NativeExtFetcher::Platform::HOST_ARCH
  end

  test 'defines HOST_DLEXT' do
    refute_nil NativeExtFetcher::Platform::HOST_DLEXT
  end

  test 'native_extension_key returns a Symbol' do
    assert_kind_of Symbol, NativeExtFetcher::Platform.native_extension_key
  end

  test 'native_extension_file_postfix returns a String' do
    assert_kind_of String, NativeExtFetcher::Platform.native_extension_file_postfix
  end
end
