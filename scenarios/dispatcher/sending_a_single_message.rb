require 'helper'

describe 'sending a single message' do
  subject          { Esendex.new(username, password) }
  let(:username)   { String.generate }
  let(:password)   { String.generate }
  let(:accounts)   { Accounts.generate(1) }
  let(:account)    { accounts.first }
  let(:recipient)  { PhoneNumber.generate }
  let(:body)       { String.generate }
  let(:batch_id)   { Guid.generate }
  let(:header_uri) { Uri.generate }
  let(:header_id)  { Guid.generate }

  let(:request_body) {
    <<EOS
<?xml version="1.0" encoding="utf-8"?>
<messages>
  <accountreference>#{account.reference}</accountreference>
  <message>
    <to>#{recipient}</to>
    <body>#{body}</body>
  </message>
</messages>
EOS
  }

  let(:response_body) {
    <<EOS
<?xml version="1.0" encoding="utf-8"?>
<messageheaders batchid="#{batch_id}"
    xmlns="http://api.esendex.com/ns/">
  <messageheader uri="#{header_uri}" id="#{header_id}" />
</messageheaders>
EOS
  }

  before {
    stub_request(:get, "https://#{username}:#{password}@api.esendex.com/v1.0/accounts?")
      .with(headers: {"User-Agent" => Esendex::Client::USER_AGENT})
      .to_return(status: 200, body: accounts.to_xml)

    stub_request(:post, "https://#{username}:#{password}@api.esendex.com/v1.0/messagedispatcher")
      .with(headers: {"User-Agent" => Esendex::Client::USER_AGENT},
            body: request_body)
      .to_return(status: 200, body: response_body)
  }

  it 'returns the created message batch' do
    returned = subject.account(account.reference).dispatcher.send(body, recipient)
  end
end
