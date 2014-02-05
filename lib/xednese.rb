require 'net/http'
require 'nokogiri'
require 'seq/paged'
require 'serialisable'
require 'time'

require_relative 'xednese/client'
require_relative 'xednese/version'

require_relative 'xednese/requests/messages'

require_relative 'xednese/responses/parser'
require_relative 'xednese/responses/account'
require_relative 'xednese/responses/accounts'
require_relative 'xednese/responses/message_dispatcher_headers'
require_relative 'xednese/responses/message_header'
require_relative 'xednese/responses/message_headers'

require_relative 'xednese/accounts'
require_relative 'xednese/dispatcher'
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

  def dispatcher
    Dispatcher.new(@credentials)
  end

  def user
    Users.new(@credentials)
  end

  def messages
    Messages.new(@credentials)
  end
end
