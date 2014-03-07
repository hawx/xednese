class MessageHeader
  def self.generate
    new id: Guid.generate,
        uri: Uri.generate,
        status: String.generate,
        laststatusat: Time.generate,
        submittedat: Time.generate,
        type: String.generate,
        to: PhoneNumber.generate,
        from: PhoneNumber.generate,
        summary: String.generate,
        body: Uri.generate,
        direction: String.generate,
        parts: Int.generate,
        username: String.generate
  end

  def initialize(hsh)
    @hsh = hsh
  end

  def to_xml
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
  end

  def method_missing(sym, *args)
    return @hsh[sym] if @hsh.has_key?(sym)
    super
  end
end
