require 'helper'

describe Esendex::Messages do
  let(:credentials) { dummy_credentials }
  subject { Esendex::Messages.new(credentials) }

  describe '#sent' do
    let(:data) { mock }
    let(:data_list) { [mock, mock] }
    let(:messages) { stub(message_headers: data_list) }
    let(:message_list) { [mock, mock] }

    before {
      Esendex::Client
        .expects(:get)
        .with(credentials, 'v1.0/messageheaders', startIndex: 0, count: 25)
        .yields(200, data)
        .returns(message_list)

      Esendex::Client
        .expects(:get)
        .with(credentials, 'v1.0/messageheaders', startIndex: 25, count: 25)
        .yields(200, nil)
        .returns([])

      Esendex::Responses::MessageHeaders
        .expects(:deserialise)
        .with(data)
        .returns(messages)

      messages.expects(:message_headers).returns(data_list)
    }

    it 'returns the messages sent by the user on the account' do
      returned_messages = []
      subject.sent.each do |message|
        returned_messages << message
      end

      returned_messages.must_equal message_list
    end
  end

  describe '#received' do
    let(:data) { mock }
    let(:data_list) { [mock, mock] }
    let(:messages) { stub(messages: data_list) }
    let(:message_list) { [mock, mock] }

    before {
      Esendex::Client
        .expects(:get)
        .with(credentials, "v1.0/inbox/messages", startIndex: 0, count: 25)
        .yields(200, data)
        .returns(message_list)

      Esendex::Client
        .expects(:get)
        .with(credentials, "v1.0/inbox/messages", startIndex: 25, count: 25)
        .yields(200, nil)
        .returns([])

      Esendex::Responses::MessageHeaders
        .expects(:deserialise)
        .with(data)
        .returns(messages)

      messages.expects(:message_headers).returns(data_list)
    }

    it 'returns the messages received by the user on the account' do
      returned_messages = []
      subject.received.each do |message|
        returned_messages << message
      end

      returned_messages.must_equal message_list
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
      sent = subject.get(message_id)
      sent.must_equal parsed_message
    end
  end
end
