require 'helper'

describe Esendex::Account::Dispatcher do
  let(:reference)   { mock }
  let(:credentials) { dummy_credentials }
  subject { Esendex::Account::Dispatcher.new(credentials, reference) }

  describe '.send' do
    let(:body) { 'Hey I am message' }
    let(:to) { '44123456789' }
    let(:messages) { mock }
    let(:response_xml) { mock }
    let(:response_message_headers) { mock }

    before {
      args = {
        account_reference: reference,
        messages: [{ to: to, body: body }]
      }

      Esendex::Requests::Messages
        .expects(:new)
        .with(args)
        .returns(messages)

      Esendex::Responses::MessageDispatcherHeaders
        .expects(:deserialise)
        .with(response_xml)
        .returns(response_message_headers)

      Esendex::Client
        .expects(:post)
        .with(credentials, 'v1.0/messagedispatcher', messages)
        .yields(200, response_xml)
        .returns(response_message_headers)
    }

    it 'sends a single message' do
      subject.send(body, to).must_equal response_message_headers
    end
  end
end
