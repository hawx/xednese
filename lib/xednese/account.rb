class Esendex

  class Account
    def initialize(credentials, response)
      @credentials = credentials
      @response = response
    end

    # @return [Dispatcher]
    # @see http://developers.esendex.com/APIs/REST-API/messagedispatcher
    def dispatcher
      Dispatcher.new(@credentials, reference)
    end

    # @return [Messages]
    def messages
      Messages.new(@credentials, reference)
    end

    extend Forwardable

    def_delegators :@response, :id, :reference, :address, :type,
                   :messages_remaining, :expires_on, :role

    def label
      @label || @response.label
    end

    def label=(value)
      request = Requests::Account.new(label: value)

      Client.put(@credentials, "v1.0/accounts/#{id}", request) do |code, body|
        @label = value
      end
    end
  end
end
