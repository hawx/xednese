class Esendex
  class Messages
    def initialize(credentials)
      @credentials = credentials
    end

    def sent
      Seq::Paged.new do |page|
        Client.get(@credentials, 'v1.0/messageheaders', page: page) do |status, data|
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
