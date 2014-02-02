class Esendex
  class Dispatcher
    def initialize(credentials)
      @credentials = credentials
    end

    def send(body, to)
      args = {
        account_reference: @credentials.account_reference,
        messages: [{to: to, body: body}]
      }

      messages = Requests::Messages.new(args)

      Client.post(@credentials, 'v1.0/messagedispatcher', messages) do |code, body|
        Responses::MessageDispatcherHeaders.deserialise(body)
      end
    end
  end
end
