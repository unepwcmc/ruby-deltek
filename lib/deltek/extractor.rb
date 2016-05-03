require 'nokogiri'
require 'nori'

module Deltek
  module Extractor
    def self.projects xml, raw
      raw ? xml : parse_collection(xml, "PR")
    end
    def self.project xml, raw
      raw ? xml : parse_row(xml)
    end

    def self.employees xml, raw
      raw ? xml : parse_collection(xml, "EM")
    end
    def self.employee xml, raw
      raw ? xml : parse_row(xml)
    end

    def self.clients xml, raw
      raw ? xml : parse_collection(xml, "CL")
    end
    def self.client xml, raw
      raw ? xml : parse_row(xml)
    end

    private

    def self.parse_row xml
      doc = Nokogiri::XML(xml)
      parser.parse(doc.xpath("//ROW").first.to_s)[:row]
    end

    def self.parse_collection xml, collection_name
      doc = Nokogiri::XML(xml)
      doc.xpath("//#{collection_name}/ROW").map { |row|
        parser.parse(row.to_s)[:row]
      }
    end

    def self.parser
      @@parser ||= Nori.new(convert_tags_to: -> tag { tag.snakecase.to_sym })
    end
  end
end
