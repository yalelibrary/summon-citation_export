# Summon::CitationExport

This provides an extension to the summon gem to convert summon documents to citation export methods, such as RIS.

It does this by implementing a single to_ris method, which returns a hash containing refworks tags as keys corresponding to field values.

It is the expectation that additional types may be added later.

## Basic Usage

```ruby
require 'summon/citation_export'
document = summon.search('shakespeare').first
document.to_ris #=> TBD
```

## Installation

summon-refworks requires ruby > 1.9.2

Gemfile

`gem 'summon-citation_export'`

standalone

`gem install summon-citation_export`
