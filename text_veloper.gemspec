# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'text_veloper/version'

Gem::Specification.new do |spec|
  spec.name = "text_veloper"
  spec.version = TextVeloper::VERSION
  spec.authors = ["Gerardo Barcia Palacios"]
  spec.email = ["gerardobarciap@gmail.com"]
  spec.description = %q{Wrapper for Textveloper API.}
  spec.summary = %q{Wrapper for Textveloper API for sending and manage SMS in Venezuela.}
  spec.homepage = "https://github.com/gbarcia/rbtextveloper"
  spec.license = "MIT"

  spec.files = `git ls-files`.split($/)
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rails', '~> 3.0.9'

  spec.add_runtime_dependency "rest-client"
end
