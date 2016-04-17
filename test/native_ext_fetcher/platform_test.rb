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

  test 'defines HOST_STATIC_EXT' do
    refute_nil NativeExtFetcher::Platform::HOST_STATIC_EXT
  end

  test 'native_extension_key returns a Symbol' do
    assert_match %r[\w+_\w+], NativeExtFetcher::Platform.native_extension_key
  end

  test 'native_extension_file_ext returns a String' do
    assert_match %r[\.\w+], NativeExtFetcher::Platform.native_extension_file_ext
  end

  test 'native_extension_static_file_ext returns a String' do
    assert_match %r[\.\w+], NativeExtFetcher::Platform.native_extension_static_file_ext
  end

  test 'native_extension_file_postfix returns a String' do
    assert_match %r[\w+-\w+\.\w+], NativeExtFetcher::Platform.native_extension_file_postfix
  end

  test 'native_extension_static_file_ext returns a String' do
    assert_match %r[\w+-\w+\.\w+], NativeExtFetcher::Platform.native_extension_static_file_postfix
  end
end
