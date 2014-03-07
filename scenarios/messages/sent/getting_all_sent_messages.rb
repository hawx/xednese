require 'helper'

describe 'getting all of my sent messages' do
  let(:username) { String.generate }
  let(:password) { String.generate }
  subject { Esendex.new(username, password) }

  let(:count) { 34 }
  let(:messages) { MessageHeaders.generate(count) }
  let(:response_body) { messages.to_xml }

  before {
    stub_request(:get, "https://#{username}:#{password}@api.esendex.com/v1.0/messageheaders?")
      .with(query: {"count" => 25, "startIndex" => 0},
            headers: {"User-Agent" => Esendex::Client::USER_AGENT})
      .to_return(status: 200, body: response_body)

    stub_request(:get, "https://#{username}:#{password}@api.esendex.com/v1.0/messageheaders?")
      .with(query: {"count" => 25, "startIndex" => 25},
            headers: {"User-Agent" => Esendex::Client::USER_AGENT})
      .to_return(status: 200, body: MessageHeaders.generate(0).to_xml)
  }

  it 'returns an Enumerable that iterates over my sent messages' do
    returned_messages = subject.messages.sent.entries

    returned_messages.size.must_equal count

    returned_messages.zip(messages) do |returned, expected|
      returned.id.must_equal expected.id
      returned.status.must_equal expected.status
      returned.last_status_at.must_equal expected.laststatusat
      returned.submitted_at.must_equal expected.submittedat
      returned.type.must_equal expected.type
      returned.to.phonenumber.must_equal expected.to
      returned.from.phonenumber.must_equal expected.from
      returned.summary.must_equal expected.summary
      returned.body.uri.must_equal expected.body
      returned.direction.must_equal expected.direction
      returned.parts.must_equal expected.parts
      returned.username.must_equal expected.username
    end
  end
end
