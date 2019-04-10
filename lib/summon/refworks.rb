require 'yaml'
require 'summon'
require "summon/refworks/version"
module Summon
  module Refworks
    def to_refworks(options = {})
      Builder.build self, options
    end

    def to_refworks_text(options = {})
      buffer = StringIO.new
      to_refworks(options).each do |key, values|
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
        document.to_refworks_tagged_format options
      end

      def refworks_tags
        filename = File.expand_path("../mappings.rb", __FILE__)
        eval(File.read(filename), binding, filename, 1)
      end

      def refworks_normal(value)
        if value.kind_of?(Array)
          value.tag_per_value? ? value : [value.join(', ')]
        else
          [value]
        end.compact
      end

      def content_type_to_reference_type
        mapping = YAML.load(File.read File.expand_path("../RT.yaml", __FILE__))
        mapping[content_type] || 'Generic'
      end

      def to_refworks_tagged_format(options)
        {}.tap do |tags|
          refworks_tags.merge(options).each do |tag, mapping|
            tags[tag] = refworks_normal case mapping
            when Symbol then send(mapping)
            when Proc then mapping.call()
            else mapping; end
          end
        end
      end
    end
  end
  class Document
    include Refworks
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