class Esendex
  module Requests
    class Account
      def initialize(args)
        @args = args
      end

      def serialise
        Nokogiri::XML::Builder.new(encoding: 'utf-8') do |xml|
          xml.account(xmlns: 'http://api.esendex.com/ns/') {
            xml.label @args[:label]
          }
        end.to_xml
      end
    end
  end
end
