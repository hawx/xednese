require_relative '../../helper'

describe Esendex::Responses::MessageHeaders do
  describe '.deserialise' do

    let(:startindex) { 5 }
    let(:count) { 15 }
    let(:totalcount) { 200 }

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
<messageheaders startindex="#{startindex}" count="#{count}" totalcount="#{totalcount}" xmlns="http://api.esendex.com/ns/">
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
</messageheaders>
EOS
      }

    it 'deserialises xml into a MessageHeaders instance' do
      message_headers = Esendex::Responses::MessageHeaders.deserialise(xml)

      message_headers.start_index.must_equal startindex
      message_headers.count.must_equal count
      message_headers.total_count.must_equal totalcount

      message_header = message_headers.message_headers.first

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
