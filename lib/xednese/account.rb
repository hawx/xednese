class Esendex

  class Account
    def initialize(credentials, id)
      @credentials, @id = credentials, id
    end

    def label=(value)
      request = Requests::Account.new(label: value)

      Client.put(@credentials, "v1.0/accounts/#{@id}", request) do |code, body|
        value
      end
    end
  end
end
