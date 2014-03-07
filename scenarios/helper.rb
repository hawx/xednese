require 'minitest/autorun'
require 'minitest/pride'
require 'webmock/minitest'
require 'nokogiri'
require 'xednese'

class String
  def self.generate(length = 25)
    chs = ('a'..'z').to_a + ('0'..'9').to_a + ('A'..'Z').to_a
    (0..length).map { chs[rand(chs.size)] }.join('')
  end

  def pad(with, to)
    (with * (to - size)) + self
  end
end

class Uri
  def self.generate
    "https://#{String.generate(3)}.#{String.generate(15)}.com/#{String.generate(10)}"
  end
end

class AccountReference
  def self.generate
    "EX" + rand(1e6).to_s.pad("0", 6)
  end
end

class Guid
  def self.generate
    SecureRandom.uuid
  end
end

class PhoneNumber
  def self.generate
    "44" + rand(1e9).to_s.pad("0", 9)
  end
end

class Int
  def self.generate(max = 1e6)
    rand(max)
  end
end

class Time
  def self.generate
    Time.at(628232400 + Int.generate(1e12))
  end

  def format
    strftime("%FT%Tz")
  end
end

require 'data/account'
require 'data/accounts'
require 'data/batch'
