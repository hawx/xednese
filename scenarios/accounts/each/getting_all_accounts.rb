require 'helper'

describe 'getting all of my accounts' do
  let(:username) { String.generate }
  let(:password) { String.generate }
  subject { Esendex.new(username, password) }

  let(:count) { 37 }
  let(:accounts) { Accounts.generate(count) }
  let(:response_body) { accounts.to_xml  }

  before {
    stub_request(:get, "https://#{username}:#{password}@api.esendex.com/v1.0/accounts?")
      .with(headers: {"User-Agent" => Esendex::Client::USER_AGENT})
      .to_return(status: 200, body: response_body)
  }

  it 'returns an Enumerable that iterates over my accounts' do
    returned_accounts = subject.accounts.entries

    returned_accounts.size.must_equal count

    returned_accounts.zip(accounts) do |returned, expected|
      returned.id.must_equal expected.id
      returned.reference.must_equal expected.reference
      returned.label.must_equal expected.label
      returned.address.must_equal expected.address
      returned.type.must_equal expected.type
      returned.messages_remaining.must_equal expected.messagesremaining
      returned.expires_on.must_equal expected.expireson
      returned.role.must_equal expected.role
    end
  end
end
