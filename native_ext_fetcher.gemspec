# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'native_ext_fetcher/version'

Gem::Specification.new do |spec|
  spec.name          = "native_ext_fetcher"
  spec.version       = NativeExtFetcher::VERSION
  spec.authors       = ["DefWare LLC"]
  spec.email         = ["michael@defware.io"]
  spec.license       = "MIT"

  spec.summary       = %q{Native extenstion fetch library}
  spec.description   = %q{Fetch native libraries based upon platform details}
  spec.homepage      = "https://github.com/DefWare/native_ext_fetcher"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.8"
  spec.add_development_dependency "fakefs", "~> 0.8"
end
