require 'helper'

describe Esendex::Responses::Account do
  describe '.deserialise' do

    let(:id) { "A00F0218-510D-423D-A74E-5A65342FE070" }
    let(:uri) { "http://api.esendex.com/v1.0/accounts/A00F0218-510D-423D-A74E-5A65342FE070" }
    let(:reference) { "EX0000000" }
    let(:label) { "label" }
    let(:address) { "447700900654" }
    let(:type) { "Professional" }
    let(:messagesremaining) { 2000 }
    let(:expireson) { "2999-02-25T00:00:00" }
    let(:role) { "PowerUser" }
    let(:settings_uri) { "http://api.esendex.com/v1.0/accounts/A00F0218-510D-423D-A74E-5A65342FE070/settings" }

    let(:xml) {
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
  <settings uri="#{settings_uri}" />
</account>
EOS
    }

    it 'deserialises xml into an Account instance' do
      account = Esendex::Responses::Account.deserialise(xml)

      account.id.must_equal id
      account.uri.must_equal uri
      account.reference.must_equal reference
      account.label.must_equal label
      account.address.must_equal address
      account.type.must_equal type
      account.messages_remaining.must_equal messagesremaining
      account.expires_on.must_equal expireson
      account.role.must_equal role
      account.settings.uri.must_equal settings_uri
    end
  end
end
