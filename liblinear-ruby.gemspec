# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'liblinear/version'

Gem::Specification.new do |spec|
  spec.name          = "liblinear-ruby"
  spec.version       = Liblinear::VERSION
  spec.authors       = ["Kei Tsuchiya"]
  spec.email         = ["kei.tsuchiya86@gmail.com"]
  spec.description   = %q{Ruby wrapper of LIBLINEAR using SWIG}
  spec.summary       = %q{Ruby wrapper of LIBLINEAR using SWIG}
  spec.homepage      = "https://github.com/kei500/liblinear-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.extensions << 'ext/extconf.rb'
end
