class Esendex
  class Accounts
    def initialize(credentials)
      @credentials = credentials
    end

    def reference
      @credentials.account_reference
    end

    def each(&block)
      Client.get(@credentials, 'v1.0/accounts') {|status, data|
        Responses::Accounts.deserialise(data).accounts
      }.each(&block)
    end

    include Enumerable

    def get(id)
      Client.get(@credentials, "v1.0/accounts/#{id}") do |status, data|
        Responses::Account.deserialise(data)
      end
    end
  end
end
