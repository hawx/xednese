class Esendex
  class Messages
    PAGE_COUNT = 25

    def initialize(credentials)
      @credentials = credentials
    end

    def sent
      Seq::Paged.new do |page|
        params = {
          startIndex: PAGE_COUNT * page,
          count: PAGE_COUNT
        }

        Client.get(@credentials, 'v1.0/messageheaders', params) do |status, data|
          Responses::MessageHeaders.deserialise(data).messageheaders
        end
      end
    end

    def get(id)
      Client.get(@credentials, "v1.0/messageheaders/#{id}") do |status, data|
        Responses::MessageHeader.deserialise(data)
      end
    end
  end
end
