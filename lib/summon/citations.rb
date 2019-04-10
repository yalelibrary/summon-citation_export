require 'yaml'
require 'summon'
require "summon/citations/version"

module Summon
  module Citations
    # also accepts 'refworks', 'endnote'
    def to_citation(options = {}, format_type = 'ris')
      Builder.build self, options, format_type
    end

    def to_citations_text(options = {})
      buffer = StringIO.new
      to_citation(options).each do |key, values|
        values.each do |value|
          buffer.puts "#{key} #{value}"
        end
      end
      buffer.string
    end

    module Builder
      define_method(:blank) {''}

      def self.build(document, options, format_type)
        document.extend self
        document.to_citation_tagged_format options
      end

      def citations_tags(format_type)
        filename = File.expand_path("../{#format_type}_mappings.rb", __FILE__)
        eval(File.read(filename), binding, filename, 1)
      end

      def citations_normal(value)
        if value.kind_of?(Array)
          value.tag_per_value? ? value : [value.join(', ')]
        else
          [value]
        end.compact
      end

      def content_type_to_reference_type(format_type)
        mapping = YAML.load(File.read File.expand_path("../{#format_type}.yaml", __FILE__))
        mapping[content_type] || 'Generic'
      end

      def to_citation_tagged_format(options)
        {}.tap do |tags|
          citations_tags.merge(options).each do |tag, mapping|
            tags[tag] = citations_normal case mapping
            when Symbol then send(mapping)
            when Proc then mapping.call()
            else mapping; end
          end
        end
      end
    end
  end
  class Document
    include Citations
  end
end

class ::Array
  def tag_per_value
    self.tap do
      @tag_per_value = true
    end
  end
  def tag_per_value?
    @tag_per_value
  end
end