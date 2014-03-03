class Esendex

  # Provides methods for working with Accounts. An Accounts instance is an
  # Enumerable, and will only make requests when needed.
  class Accounts

    # @see Esendex#accounts
    # @api private
    def initialize(credentials)
      @credentials = credentials
    end

    # @yield [Account] Calls the provided block with each account the user has
    #   access to
    def each(&block)
      Client.get(@credentials, 'v1.0/accounts') {|status, data|
        Responses::Accounts.deserialise(data).accounts.map do |account|
          Account.new(@credentials, account)
        end
      }.each(&block)
    end

    include Enumerable

    # @param id [String] the id of the account to return
    # @return [Account] Returns the account with the given id.
    def get(id)
      Client.get(@credentials, "v1.0/accounts/#{id}") do |status, data|
        Account.new @credentials, Responses::Account.deserialise(data)
      end
    end
  end
end
