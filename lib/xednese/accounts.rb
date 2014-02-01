class Esendex
  class Accounts
    def initialize(credentials)
      @credentials = credentials
    end

    def reference
      @credentials.account_reference
    end
  end
end
