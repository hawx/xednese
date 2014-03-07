require 'helper'

describe 'getting a message' do
  let(:username) { String.generate }
  let(:password) { String.generate }
  subject { Esendex.new(username, password) }

  let(:message_header) { MessageHeader.generate }
  let(:response_body) { message_header.to_xml }

  before {
    stub_request(:get, "https://#{username}:#{password}@api.esendex.com/v1.0/messageheaders/#{message_header.id}?")
      .with(headers: {"User-Agent" => Esendex::Client::USER_AGENT})
      .to_return(status: 200, body: response_body)
  }

  it 'returns an Enumerable that iterates over my sent messages' do
    returned = subject.messages.get(message_header.id)

    returned.id.must_equal message_header.id
    returned.status.must_equal message_header.status
    returned.last_status_at.must_equal message_header.laststatusat
    returned.submitted_at.must_equal message_header.submittedat
    returned.type.must_equal message_header.type
    returned.to.phonenumber.must_equal message_header.to
    returned.from.phonenumber.must_equal message_header.from
    returned.summary.must_equal message_header.summary
    returned.body.uri.must_equal message_header.body
    returned.direction.must_equal message_header.direction
    returned.parts.must_equal message_header.parts
    returned.username.must_equal message_header.username
  end
end
