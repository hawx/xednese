class MessageHeaders < Array
  def self.generate(n)
    new (0...n).map { MessageHeader.generate }
  end

  def startindex
    @startindex ||= Int.generate
  end

  def count
    @count ||= Int.generate
  end

  def totalcount
    @totalcount ||= Int.generate
  end

  def to_xml
    str = <<EOS
<?xml version="1.0" encoding="utf-8"?>
<messageheaders startindex="#{startindex}"
                count="#{count}"
                totalcount="#{totalcount}"
                xmlns="http://api.esendex.com/ns/">
EOS

    each do |message|
      str += <<EOS
<messageheader id="#{message.id}" uri="#{message.uri}">
  <status>#{message.status}</status>
  <laststatusat>#{message.laststatusat}</laststatusat>
  <submittedat>#{message.submittedat}</submittedat>
  <type>#{message.type}</type>
  <to>
    <phonenumber>#{message.to}</phonenumber>
  </to>
  <from>
    <phonenumber>#{message.from}</phonenumber>
  </from>
  <summary>#{message.summary}</summary>
  <body uri="#{message.body}"/>
  <direction>#{message.direction}</direction>
  <parts>#{message.parts}</parts>
  <username>#{message.username}</username>
</messageheader>
EOS
    end

    str + "</messageheaders>"
  end
end
