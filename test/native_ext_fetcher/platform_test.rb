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

  test 'platform native_extension_key includes arch and host' do
    assert_match %r[\w+_\w+], NativeExtFetcher::Platform.native_extension_key
  end

  test 'platform native_extension_file_ext matches file ext' do
    assert_match %r[\.\w+], NativeExtFetcher::Platform.native_extension_file_ext
  end

  test 'platform native_extension_static_file_ext matches static file ext' do
    assert_match %r[\.\w+], NativeExtFetcher::Platform.native_extension_static_file_ext
  end

  test 'platform native_extension_file_postfix matches' do
    assert_match %r[\w+-\w+\.\w+], NativeExtFetcher::Platform.native_extension_file_postfix
  end

  test 'paltform native_extension_static_file_ext matches' do
    assert_match %r[\w+-\w+\.\w+], NativeExtFetcher::Platform.native_extension_static_file_postfix
  end

  test 'platform native_extension_tuple' do
    assert_equal [NativeExtFetcher::Platform::HOST_ARCH, NativeExtFetcher::Platform::HOST_OS],
      NativeExtFetcher::Platform.native_extension_tuple
  end
end
