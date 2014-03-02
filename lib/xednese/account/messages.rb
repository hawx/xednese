class Esendex
  class Account
    class Messages
      PAGE_COUNT = 25

      # @see Esendex::Account#messages
      # @api private
      def initialize(credentials, reference)
        @credentials = credentials
        @reference = reference
      end

      # @return [Enumerable<Responses::MessageHeader>] an Enumerable that
      #   iterates over all sent messages. Requests are made for fixed size
      #   pages when required.
      def sent
        Seq::Paged.new do |page|
          params = {
            startIndex: PAGE_COUNT * page,
            count: PAGE_COUNT,
            accountReference: @reference
          }

          Client.get(@credentials, 'v1.0/messageheaders', params) do |status, data|
            Responses::MessageHeaders.deserialise(data).message_headers
          end
        end
      end

      # @return [Enumerable<Responses::MessageHeader>] an Enumerable that
      #   iterates over all received messages. Requests are made for fixed size
      #   pages when required.
      def received
        Seq::Paged.new do |page|
          params = {
            startIndex: PAGE_COUNT * page,
            count: PAGE_COUNT
          }

          Client.get(@credentials, "v1.0/inbox/#{@reference}/messages", params) do |status, data|
            Responses::MessageHeaders.deserialise(data).message_headers
          end
        end
      end
    end
  end
end
