# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thong/version'

Gem::Specification.new do |gem|
  gem.name          = "thong"
  gem.version       = Thong::VERSION
  gem.authors       = ["Telmo"]
  gem.email         = ["telmox@gmail.com"]
  gem.description   = %q{Self hosted version of CoverAlls}
  gem.summary       = %q{Self hosted version of CoverAlls}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'simplecov', ">= 0.7"
  gem.add_dependency 'colorize'
  gem.add_dependency 'rest-client'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'webmock', '1.7'
  gem.add_development_dependency 'vcr', '1.11.3'
end
