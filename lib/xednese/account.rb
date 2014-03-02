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

    def messages
      Messages.new(@credentials, reference)
    end

    def id
      @response.id
    end

    def reference
      @response.reference
    end

    def label
      @label || @response.label
    end

    def address
      @response.address
    end

    def type
      @response.type
    end

    def messages_remaining
      @response.messages_remaining
    end

    def expires_on
      @response.expires_on
    end

    def role
      @response.role
    end

    def label=(value)
      request = Requests::Account.new(label: value)

      Client.put(@credentials, "v1.0/accounts/#{id}", request) do |code, body|
        @label = value
      end
    end
  end
end
