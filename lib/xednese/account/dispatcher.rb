class Esendex
  class Account
    class Dispatcher

      # @see Esendex::Account#dispatcher
      # @api private
      def initialize(credentials, reference)
        @credentials = credentials
        @reference = reference
      end

      # Sends a message to a single recipient.
      # @param body [String] the message body
      # @param to [String] the number to send to
      # @return [Responses::MessageDispatcherHeaders]
      def send(body, to)
        args = {
          account_reference: @reference,
          messages: [{to: to, body: body}]
        }

        messages = Requests::Messages.new(args)

        Client.post(@credentials, 'v1.0/messagedispatcher', messages) do |code, body|
          Responses::MessageDispatcherHeaders.deserialise(body)
        end
      end
    end
  end
end
