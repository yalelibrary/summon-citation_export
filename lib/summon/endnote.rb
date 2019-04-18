require 'yaml'
require 'summon'
require "summon/citation_export/version"

module Summon
  module Endnote
    def to_endnote(options = {})
      Builder.build self, options
    end

    def to_endnote_text(options = {})
      buffer = StringIO.new
      to_endnote(options).each do |key, values|
        values.each do |value|
          buffer.puts "#{key} #{value}"
        end
      end
      buffer.string
    end

    module Builder
      define_method(:blank) {''}

      def self.build(document, options)
        document.extend self
        document.to_endnote_tagged_format options
      end

      def endnote_tags
        filename = File.expand_path("../endnote_mappings.rb", __FILE__)
        eval(File.read(filename), binding, filename, 1)
      end

      def endnote_normal(value)
        if value.kind_of?(Array)
          value.tag_per_value? ? value : [value.join(', ')]
        else
          [value]
        end.compact
      end

      def content_type_to_endnote_type
        mapping = YAML.load(File.read File.expand_path("../endnote_content_types.yaml", __FILE__))
        mapping[content_type] || 'Generic'
      end

      def to_endnote_tagged_format(options)
        {}.tap do |tags|
          endnote_tags.merge(options).each do |tag, mapping|
            tags[tag] = endnote_normal case mapping
            when Symbol then send(mapping)
            when Proc then mapping.call()
            else mapping; end
          end
        end
      end
    end
  end
  class Document
    include Endnote
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

