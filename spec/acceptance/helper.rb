require_relative '../helper'
require 'webmock/minitest'

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

class Account
  def self.generate
    new id: Guid.generate,
        uri: Uri.generate,
        reference: AccountReference.generate,
        label: String.generate,
        address: PhoneNumber.generate,
        type: String.generate,
        messagesremaining: Int.generate,
        expireson: Time.generate.format,
        role: String.generate,
        settingsuri: Uri.generate
  end

  def initialize(hsh)
    @hsh = hsh
  end

  def to_xml(partial = false)
    if partial
      <<EOS
<account id="#{id}" uri="#{uri}">
  <reference>#{reference}</reference>
  <label>#{label}</label>
  <address>#{address}</address>
  <type>#{type}</type>
  <messagesremaining>#{messagesremaining}</messagesremaining>
  <expireson>#{expireson}</expireson>
  <role>#{role}</role>
  <settings uri="#{settingsuri}" />
</account>
EOS
    else
      <<EOS
<?xml version="1.0" encoding="utf-8"?>
<account id="#{id}" uri="#{uri}" xmlns="http://api.esendex.com/ns/">
  <reference>#{reference}</reference>
  <label>#{label}</label>
  <address>#{address}</address>
  <type>#{type}</type>
  <messagesremaining>#{messagesremaining}</messagesremaining>
  <expireson>#{expireson}</expireson>
  <role>#{role}</role>
  <settings uri="#{settingsuri}" />
</account>
EOS
    end
  end

  def method_missing(sym, *args)
    if @hsh.has_key?(sym)
      return @hsh[sym]
    end

    super
  end
end
