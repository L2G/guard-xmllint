# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guard/xmllint/version'

Gem::Specification.new do |spec|
  spec.name          = 'guard-xmllint'
  spec.version       = Guard::XmlLint::VERSION
  spec.authors       = ['Larry Gilbert']
  spec.email         = ['larry@L2G.to']
  spec.description   = 'Guard plugin for checking XML files for well-' +
                       'formedness and validity'
  spec.summary       = spec.description
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'guard', '~> 1.8.2'
  spec.add_dependency 'xml-simple', '~> 1.1.2'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
