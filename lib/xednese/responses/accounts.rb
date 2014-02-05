class Esendex
  module Responses
    class Accounts
      extend Serialisable

      root 'accounts'
      elements :accounts, Account
    end
  end
end
