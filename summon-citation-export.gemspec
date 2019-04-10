# -*- encoding: utf-8 -*-
require File.expand_path('../lib/summon/refworks/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Serials Solutions, Inc."]
  gem.email         = ["summon@serialssolutions.com"]
  gem.description   = %q{convert summon documents to refworks tagged format}
  gem.summary       = %q{Summon has a schema, so does Refworks. this handy tool lets you go from one to the other}
  gem.homepage      = "https://github.com/summon/summon-refworks.rb"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "summon-refworks"
  gem.require_paths = ["lib"]
  gem.version       = Summon::Refworks::VERSION

  gem.add_dependency 'summon', '~> 2.0.0'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
