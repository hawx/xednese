require 'helper'

describe 'getting an account' do
  let(:username) { String.generate }
  let(:password) { String.generate }
  subject { Esendex.new(username, password) }

  let(:account) { Account.generate }
  let(:response_body) { account.to_xml }

  before {
    stub_request(:get, "https://#{username}:#{password}@api.esendex.com/v1.0/accounts/#{account.id}?")
      .with(headers: {"User-Agent" => Esendex::Client::USER_AGENT})
      .to_return(status: 200, body: response_body)
  }

  it 'returns an Enumerable that iterates over my accounts' do
    returned = subject.accounts.get(account.id)

    returned.id.must_equal account.id
    returned.reference.must_equal account.reference
    returned.label.must_equal account.label
    returned.address.must_equal account.address
    returned.type.must_equal account.type
    returned.messages_remaining.must_equal account.messagesremaining
    returned.expires_on.must_equal account.expireson
    returned.role.must_equal account.role
  end
end
