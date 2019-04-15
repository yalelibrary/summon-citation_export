# -*- encoding: utf-8 -*-
require File.expand_path('../lib/summon/citation_export/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Yale University Library"]
  gem.email         = ["engineering@yale.edu"]
  gem.description   = %q{convert summon documents to citation formats}
  gem.summary       = %q{Summon has a schema, so do Refworks, Endnote, RIS. This handy tool lets you go from one to the others}
  gem.homepage      = "https://github.com/yalelibrary/summon-citation-export.rb"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "summon-citation-export"
  gem.require_paths = ["lib"]
  gem.version       = Summon::CitationExport::VERSION

  gem.add_dependency 'summon', '~> 2.0.0'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
