class Esendex
  module Requests
    class Messages
      def initialize(args)
        @args = args
      end

      def serialise
        Nokogiri::XML::Builder.new(:encoding => 'utf-8') do |xml|
          xml.messages {
            xml.accountreference @args[:account_reference]

            @args[:messages].each do |message|
              xml.message {
                xml.to message[:to]
                xml.body message[:body]
              }
            end
          }
        end.to_xml
      end
    end
  end
end
