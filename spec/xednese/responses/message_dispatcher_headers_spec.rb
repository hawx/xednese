require_relative '../../helper'

describe Esendex::Responses::MessageDispatcherHeaders do
  subject { Esendex::Responses::MessageDispatcherHeaders }

  describe '.deserialise' do
    let(:batch_id) { "F8BF9867-FF81-49E4-ACC5-774DE793B776" }
    let(:header_uri) { "https://api.esendex.com/v1.0/MessageHeaders/1183C73D-2E62-4F60-B610-30F160BDFBD5" }
    let(:header_id) { "1183C73D-2E62-4F60-B610-30F160BDFBD5" }

    let(:xml) {
      <<EOS
<?xml version="1.0" encoding="utf-8"?>
<messageheaders batchid="#{batch_id}"
    xmlns="http://api.esendex.com/ns/">
  <messageheader uri="#{header_uri}" id="#{header_id}" />
</messageheaders>
EOS
    }

    it 'deserialises xml into a MessageDispatcherHeaders instance' do
      headers = subject.deserialise(xml)

      headers.batch_id.must_equal batch_id
      headers.message_headers.first.uri.must_equal header_uri
      headers.message_headers.first.id.must_equal header_id
    end
  end
end
