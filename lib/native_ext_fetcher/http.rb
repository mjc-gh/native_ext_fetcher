require 'fileutils'
require 'digest/sha2'
require 'net/http'
require 'uri'

module NativeExtFetcher
  class Http
    MAX_REDIRECTS = 5
    MAX_RETRIES   = 3

    MaxRedirect = Class.new(Error)
    MaxRetries  = Class.new(Error)

    def initialize(options = {})
      @max_redirects = options[:max_redirects] || MAX_REDIRECTS
      @max_retries   = options[:max_retries] || MAX_RETRIES

      if http_proxy = ENV['HTTP_PROXY'] || ENV['http_proxy']
        uri = URI.parse(http_proxy)

        @proxy_host, @proxy_port = uri.host, uri.port
        @proxy_user, @proxy_pass = uri.userinfo.split(/:/) if uri.userinfo
      end
    end

    def get_file(out, uri)
      remaining_attempts = @max_retries

      @max_redirects.times do |i|
        begin
          host, port, path = deconstruct_uri(uri)
          status, result = http_get(out, host, port, path)

          case status
          when :success
            return result

          else uri = result
          end

        rescue => e
          remaining_attempts -= 1

          unless remaining_attempts.zero?
            sleep 2
            retry
          end

          raise MaxRetries, "max retries; #{e.message} (#{uri})"
        end
      end

      raise MaxRedirect, "max redirects hit (#{uri})"
    end

    protected

    def deconstruct_uri(uri)
      uri = URI.parse(uri)

      [ uri.host, uri.port, uri.path ]
    end

    def http_get(out, host, port, path)
      Net::HTTP.start(host, port, @proxy_host, @proxy_pass, @proxy_user, @proxy_pass, use_ssl: true) do |http|
        http.request_get path do |resp|
          case resp
          when Net::HTTPSuccess
            digest = Digest::SHA2.new

            resp.read_body do |chunk|
              digest << chunk
              out.write chunk
            end

            return :success, digest.hexdigest

          when Net::HTTPRedirection
            unless location = resp['location']
              raise "received redirect but no location"
            end

            return :redirect, location
          else
            raise "received HTTP status code #{resp.code}"
          end
        end
      end
    end
  end
end
