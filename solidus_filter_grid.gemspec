# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'solidus_filter_grid/version'

Gem::Specification.new do |spec|
  spec.name          = "solidus_filter_grid"
  spec.version       = SolidusFilterGrid::VERSION
  spec.authors       = ["Noel"]
  spec.email         = ["noel@2bedigital.com"]

  spec.summary       = %q{2Bedigital Solidus filter and sort grid product}
  spec.description   = %q{2Bedigital Solidus filter and sort grid product}
  spec.homepage      = "https://github.com/2beDigital/solidus_filter_grid"
  spec.license       = "MIT"


  spec.require_paths = ["lib"]

  spec.add_dependency 'font-awesome-rails'
  
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  
end
