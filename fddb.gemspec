# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fddb/version'

Gem::Specification.new do |spec|
  spec.name          = "fddb"
  spec.version       = FDDB::VERSION
  spec.authors       = ["thomas mayrhofer"]
  spec.email         = ["thomas@mayrhofer.at"]
  spec.description   = %q{This gem is an implementation of the fddb.info API to get food related information.}
  spec.summary       = %q{This gem helps to access data from the fddb.info API}
  spec.homepage      = "https://github.com/webPapaya/fddb"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
