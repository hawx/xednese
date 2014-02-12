class Esendex
  class Messages
    PAGE_COUNT = 25

    # @see Esendex#messages
    # @api private
    def initialize(credentials)
      @credentials = credentials
    end

    # @return [Enumerable<Responses::MessageHeader>] an Enumerable that iterates
    #   over all sent messages. Requests are made for fixed size pages when
    #   required.
    def sent
      Seq::Paged.new do |page|
        params = {
          startIndex: PAGE_COUNT * page,
          count: PAGE_COUNT
        }

        Client.get(@credentials, 'v1.0/messageheaders', params) do |status, data|
          Responses::MessageHeaders.deserialise(data).message_headers
        end
      end
    end

    # @return [Enumerable<Responses::MessageHeader>] an Enumerable that iterates
    #   over all received messages. Requests are made for fixed size pages when
    #   required.
    def received
      Seq::Paged.new do |page|
        params = {
          startIndex: PAGE_COUNT * page,
          count: PAGE_COUNT
        }

        Client.get(@credentials, 'v1.0/inbox/messages', params) do |status, data|
          Responses::MessageHeaders.deserialise(data).message_headers
        end
      end
    end

    # @param id [String] the id of the message to get
    # @return [Responses::MessageHeader] the MessageHeader specified by the id
    #   given
    def get(id)
      Client.get(@credentials, "v1.0/messageheaders/#{id}") do |status, data|
        Responses::MessageHeader.deserialise(data)
      end
    end
  end
end
