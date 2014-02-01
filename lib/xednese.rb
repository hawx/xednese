require_relative 'xednese/client'
require_relative 'xednese/version'

require_relative 'xednese/accounts'
require_relative 'xednese/messages'
require_relative 'xednese/users'

class Esendex
  Credentials = Struct.new(:username, :password, :account_reference)

  def initialize(username, password, account_reference)
    @credentials = Credentials.new(username, password, account_reference)
  end

  def account
    Accounts.new(@credentials)
  end

  def user
    Users.new(@credentials)
  end

  def messages
    Messages.new(@credentials)
  end
end
