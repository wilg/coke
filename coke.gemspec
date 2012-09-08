# -*- encoding: utf-8 -*-
require File.expand_path('../lib/coke/version', __FILE__)

Gem::Specification.new do |gem|

  gem.authors       = ["Wil Gieseler"]
  gem.email         = ["supapuerco@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "coke"
  gem.require_paths = ["lib"]
  gem.version       = Coke::VERSION

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'racc'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rexical'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'guard-shell'

end
