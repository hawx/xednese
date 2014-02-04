require_relative '../helper'

describe Esendex::Messages do
  subject { dummy_esendex }
  let(:credentials) { subject.instance_variable_get(:@credentials) }

  describe '#sent' do
    let(:xml) { "Hey I'm xml" }
    let(:first_message) { Object.new }
    let(:parsed_messages) { stub(messageheaders: [first_message]) }

    before {
      Esendex::Client
        .expects(:get)
        .with(credentials, 'v1.0/messageheaders', startIndex: 0, count: 25)
        .yields(200, xml)
        .returns(parsed_messages.messageheaders)

      Esendex::Responses::MessageHeaders
        .expects(:deserialise)
        .with(xml)
        .returns(parsed_messages)
    }

    it 'returns the messages sent by the user on the account' do
      sent = subject.messages.sent
      sent.first.must_equal first_message
    end
  end

  describe '#get' do
    let(:message_id) { "guid" }
    let(:xml) { "Hey I'm xml" }
    let(:parsed_message) { Object.new }

    before {
      Esendex::Client
        .expects(:get)
        .with(credentials, "v1.0/messageheaders/#{message_id}")
        .yields(200, xml)
        .returns(parsed_message)

      Esendex::Responses::MessageHeader
        .expects(:deserialise)
        .with(xml)
        .returns(parsed_message)
    }

    it 'returns the message sent with the given id' do
      sent = subject.messages.get(message_id)
      sent.must_equal parsed_message
    end
  end
end
