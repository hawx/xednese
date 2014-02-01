class Esendex
  class Users
    def initialize(credentials)
      @credentials = credentials
    end

    def username
      @credentials.username
    end

    def password
      @credentials.password
    end
  end
end
