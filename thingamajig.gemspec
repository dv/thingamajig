# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thingamajig/version'

Gem::Specification.new do |spec|
  spec.name          = "thingamajig"
  spec.version       = Thingamajig::VERSION
  spec.authors       = ["David Verhasselt"]
  spec.email         = ["david@crowdway.com"]

  spec.summary       = %q{A library providing an OOPy API for a local Things 3 Mac app}
  spec.description   = %q{A library providing an OOPy API for a local Things 3 Mac app, allowing you to manipulate Projects, Areas, Todos, etc}
  spec.homepage      = "https://github.com/dv/thingamajig"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "rb-scpt"
end
