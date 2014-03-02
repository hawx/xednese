require_relative '../../helper'

describe Esendex::Account::Messages do
  let(:credentials) { dummy_credentials }
  let(:reference)   { "EX00000" }
  subject { Esendex::Account::Messages.new(credentials, reference) }

  describe '#sent' do
    let(:xml) { "Hey I'm xml" }
    let(:first_message) { Object.new }
    let(:parsed_messages) { stub(message_headers: [first_message]) }

    before {
      Esendex::Client
        .expects(:get)
        .with(credentials, 'v1.0/messageheaders',
              startIndex: 0, count: 25, accountReference: reference)
        .yields(200, xml)
        .returns(parsed_messages.message_headers)

      Esendex::Responses::MessageHeaders
        .expects(:deserialise)
        .with(xml)
        .returns(parsed_messages)
    }

    it 'returns the messages sent by the user on the account' do
      sent = subject.sent
      sent.first.must_equal first_message
    end
  end

  describe '#received' do
    let(:xml) { "Hey I'm xml" }
    let(:first_message) { mock }
    let(:parsed_messages) { stub(message_headers: [first_message]) }

    before {
      Esendex::Client
        .expects(:get)
        .with(credentials, "v1.0/inbox/#{reference}/messages", startIndex: 0, count: 25)
        .yields(200, xml)
        .returns(parsed_messages.message_headers)

      Esendex::Responses::MessageHeaders
        .expects(:deserialise)
        .with(xml)
        .returns(parsed_messages)
    }

    it 'returns the messages received by the user on the account' do
      received = subject.received
      received.first.must_equal first_message
    end
  end
end
