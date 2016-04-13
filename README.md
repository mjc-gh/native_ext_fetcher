# NativeExtFetcher

This is a simple gem designed to be used in an extconf.rb file for
Ruby gems with native extensions. It will detect and normalize host
details and will attempt to download the proper native library from a
remote host. This is especially useful with gems that use Rust native
libraries.

This code was abstracted from the
[Skylight](https://github.com/skylightio/skylight-ruby) gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'native_ext_fetcher'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install native_ext_fetcher

## Usage

To use this gem, you'd add something like following to your gem's
extconf.rb

```ruby
include NativeExtFetcher

# Configure the NativeExtFetcher
native_ext_config 's3.amazonaws.com/bucket_name/some/path', __dir__, {
  linux_x86_64: '[sha2 checksum]'
}

# Fetch the library from S3
native_ext_fetch! 'libmynativelib'

# Setup our Makefile as normal
LIB_DIRS = [RbConfig::CONFIG['libdir'], native_ext_download_path]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/native_ext_fetcher. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

