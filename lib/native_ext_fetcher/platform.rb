require 'rbconfig'

module NativeExtFetcher
  module Platform
    class << self
      protected

      def determine_host_os
        case os = RbConfig::CONFIG['host_os'].downcase
        when /linux/
          'linux'
        when /darwin/
          'darwin'
        when /freebsd/
          'freebsd'
        when /netbsd/
          'netbsd'
        when /openbsd/
          'openbsd'
        when /sunos|solaris/
          'solaris'
        when /mingw|mswin/
          'windows'
        else os
        end
      end

      def determine_host_arch
        case cpu = RbConfig::CONFIG['host_cpu'].downcase
        when /amd64|x86_64/
          'x86_64'
        when /i?86|x86|i86pc/
          'x86'
        when /ppc|powerpc/
          'powerpc'
        when /^arm/
          'arm'
        else
          cpu
        end
      end

      def determine_host_dlext
        RbConfig::CONFIG['DLEXT'].downcase
      end

      def determine_host_static_ext(os)
        case os
        when 'windows'
          'lib'
        else
          'a'
        end
      end
    end

    HOST_OS    = determine_host_os.freeze
    HOST_ARCH  = determine_host_arch.freeze
    HOST_DLEXT = determine_host_dlext.freeze

    HOST_STATIC_EXT = determine_host_static_ext(HOST_OS).freeze

    def self.native_extension_key
      :"#{HOST_OS}_#{HOST_ARCH}"
    end

    def self.native_extension_file_postfix
      "-#{HOST_OS}-#{HOST_ARCH}.#{HOST_DLEXT}"
    end

    def self.native_extension_static_file_postfix
      "-#{HOST_OS}-#{HOST_ARCH}.#{HOST_STATIC_EXT}"
    end

    def self.native_extension_file_ext
      ".#{HOST_DLEXT}"
    end

    def self.native_extension_static_file_ext
      ".#{HOST_STATIC_EXT}"
    end

    def self.native_extension_tuple
      [HOST_OS, HOST_ARCH]
    end
  end
end
