module NativeExtFetcher
  class Fetcher
    InvalidDigest = Class.new(StandardError)

    attr_reader :download_path

    def config(host, path, checksums, options = {})
      @lib_path = File.expand_path(File.join(path, '..', '..', 'lib'))

      raise ArgumentError, 'Checksums must be a hash' unless Hash === checksums
      raise ArgumentError, 'Library path not found ' unless Dir.exists?(@lib_path)

      @host = host
      @checksums = checksums
      @options = options

      @download_path = expand_download_path
    end

    def fetch!(library)
      File.open(library_local_path(library), 'w+') do |file|
        file.truncate 0 # empty file

        uri = library_request_uri(library)
        digest = http_client.get_file(file, uri)

        unless digest == expected_digest
          raise InvalidDigest, "invalid checksums for #{library} from #{uri}"
        end
      end
    end

    protected

    def http_client
      @http_client ||= Http.new(@options)
    end

    def expected_digest
      @checksums[Platform.native_extension_key]
    end

    def library_local_path(library)
      File.join @download_path, "#{library}#{Platform.native_extension_file_ext}"
    end

    def library_request_uri(library)
      "https://#{@host}/#{library}#{Platform.native_extension_file_postfix}"
    end

    def expand_download_path
      File.join(@lib_path, 'native', *Platform.native_extension_tuple).tap do |native_path|
        FileUtils.mkdir_p native_path
      end
    end
  end
end
