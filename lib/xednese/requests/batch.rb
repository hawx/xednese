class Esendex
  module Requests
    class Batch
      def initialize(args)
        @args = args
      end

      def serialise
        Nokogiri::XML::Builder.new(encoding: 'utf-8') do |xml|
          xml.messagebatch(xmlns: 'http://api.esendex.com/ns/') {
            xml.name @args[:name]
          }
        end.to_xml
      end
    end
  end
end
