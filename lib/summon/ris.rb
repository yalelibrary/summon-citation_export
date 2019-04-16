require 'yaml'
require 'summon'
require "summon/citation_export/version"

module Summon
  module Ris
    def to_ris(options = {})
      Builder.build self, options
    end

    def to_ris_text(options = {})
      buffer = StringIO.new
      to_ris(options).each do |key, values|
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
        document.to_ris_tagged_format options
      end

      def ris_tags
        filename = File.expand_path("../ris_mappings.rb", __FILE__)
        eval(File.read(filename), binding, filename, 1)
      end

      def ris_normal(value)
        if value.kind_of?(Array)
          value.tag_per_value? ? value : [value.join(', ')]
        else
          [value]
        end.compact
      end

      def content_type_to_ris_type
        mapping = YAML.load(File.read File.expand_path("../ris_content_types.yaml", __FILE__))
        mapping[content_type] || 'GEN'
      end

      def to_ris_tagged_format(options)
        {}.tap do |tags|
          ris_tags.merge(options).each do |tag, mapping|
            tags[tag] = ris_normal case mapping
            when Symbol then send(mapping)
            when Proc then mapping.call()
            else mapping; end
          end
        end
      end
    end
  end
  class Document
    include Ris
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

