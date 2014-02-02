require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/mini_test'

require_relative '../lib/xednese'

def dummy_esendex
  Esendex.new('what', 'when', 'really?')
end

def dummy_credentials
  Esendex::Credentials.new('user', 'pass', 'what?')
end
