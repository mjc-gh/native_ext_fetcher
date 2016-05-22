require 'fileutils'

require 'native_ext_fetcher/version'
require 'native_ext_fetcher/error'
require 'native_ext_fetcher/platform'
require 'native_ext_fetcher/fetcher'
require 'native_ext_fetcher/http'

module NativeExtFetcher
  def self.instance
    @instance ||= Fetcher.new
  end

  instance.public_methods(false).each do |method|
    class_eval <<-RUBY_EVAL
      def native_ext_#{method}(*args)
        NativeExtFetcher.instance.#{method}(*args)
      end
    RUBY_EVAL
  end
end
