require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/mini_test'

require 'xednese'

def dummy_esendex
  Esendex.new('what', 'when')
end

def dummy_credentials
  Esendex::Credentials.new('user', 'pass')
end
