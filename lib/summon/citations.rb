require 'yaml'
require 'summon'
require "summon/citations/version"

module Summon
  module Citations
    # also accepts 'refworks', 'endnote'
    def to_citation(format_Type = 'ris', options = {})
      Builder.build self, options, format_type
    end

    def to_refworks(options = {})
      to_citation('refworks', options)
    end

    def to_refworks_text(options = {})
      to_citation_text('refworks', options)
    end

    def to_endnote(options = {})
      to_citation('endnote', options)
    end

    def to_endnote_text(options = {})
      to_citation_text('endnote', options)
    end

    def to_ris(options = {})
      to_citation(options)
    end

    def to_ris_text(options = {})
      to_citation_text(options)
    end

    def to_citation_text(format_type = 'ris', options = {})
      buffer = StringIO.new
      to_citation(format_type, options).each do |key, values|
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
        @options = options
        @format_type = format_type
      end

      def citations_tags
        filename = File.expand_path("../#{@format_type}_mappings.rb", __FILE__)
        eval(File.read(filename), binding, filename, 1)
      end

      def citations_normal(value)
        if value.kind_of?(Array)
          value.tag_per_value? ? value : [value.join(', ')]
        else
          [value]
        end.compact
      end

      def content_type_to_reference_type
        mapping = YAML.load(File.read File.expand_path("../#{@format_type}_content_types.yaml", __FILE__))
        mapping[content_type] || 'Generic'
      end

      def to_citation_tagged_format
        {}.tap do |tags|
          citations_tags.merge(@options).each do |tag, mapping|
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