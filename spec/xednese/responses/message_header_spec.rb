require_relative '../../helper'

describe Esendex::Responses::MessageHeader do
  describe '.deserialise' do

    let(:id) { "CDEB3533-1F76-46D7-A2A9-0DAF8290F7FC" }
    let(:uri) { "http://api.esendex.com/v1.0/messageheaders/CDEB3533-1F76-46D7-A2A9-0DAF8290F7FC/" }
    let(:status) { "Delivered" }
    let(:laststatusat) { "2010-01-01T12:00:05.000" }
    let(:submittedat) { "2010-01-01T12:00:02.000" }
    let(:type) { "SMS" }
    let(:to) { "447700900123" }
    let(:from) { "447700900654" }
    let(:summary) { "Testing REST API" }
    let(:body) { "http://api.esendex.com/v1.0/messageheaders/CDEB3533-1F76-46D7-A2A9-0DAF8290F7FC/body" }
    let(:direction) { "Outbound" }
    let(:parts) { 1 }
    let(:username) { "user@example.com" }

    let(:xml) {
      <<EOS
<?xml version="1.0" encoding="utf-8"?>
<messageheader id="#{id}" uri="#{uri}" xmlns="http://api.esendex.com/ns/">
  <status>#{status}</status>
  <laststatusat>#{laststatusat}</laststatusat>
  <submittedat>#{submittedat}</submittedat>
  <type>#{type}</type>
  <to>
    <phonenumber>#{to}</phonenumber>
  </to>
  <from>
    <phonenumber>#{from}</phonenumber>
  </from>
  <summary>#{summary}</summary>
  <body uri="#{body}"/>
  <direction>#{direction}</direction>
  <parts>#{parts}</parts>
  <username>#{username}</username>
</messageheader>
EOS
      }

    it 'deseralises xml into a MessageHeader instance' do
      message_header = Esendex::Responses::MessageHeader.deserialise(xml)

      message_header.id.must_equal id
      message_header.uri.must_equal uri
      message_header.status.must_equal status
      message_header.last_status_at.must_equal Time.parse(laststatusat)
      message_header.submitted_at.must_equal Time.parse(submittedat)
      message_header.type.must_equal type
      message_header.to.phonenumber.must_equal to
      message_header.from.phonenumber.must_equal from
      message_header.summary.must_equal summary
      message_header.body.uri.must_equal body
      message_header.direction.must_equal direction
      message_header.parts.must_equal parts
      message_header.username.must_equal username
    end
  end
end
