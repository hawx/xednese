class Account
  def self.generate
    new id: Guid.generate,
        uri: Uri.generate,
        reference: AccountReference.generate,
        label: String.generate,
        address: PhoneNumber.generate,
        type: String.generate,
        messagesremaining: Int.generate,
        expireson: Time.generate.format,
        role: String.generate,
        settingsuri: Uri.generate
  end

  def initialize(hsh)
    @hsh = hsh
  end

  def to_xml
    <<EOS
<?xml version="1.0" encoding="utf-8"?>
<account id="#{id}" uri="#{uri}" xmlns="http://api.esendex.com/ns/">
  <reference>#{reference}</reference>
  <label>#{label}</label>
  <address>#{address}</address>
  <type>#{type}</type>
  <messagesremaining>#{messagesremaining}</messagesremaining>
  <expireson>#{expireson}</expireson>
  <role>#{role}</role>
  <settings uri="#{settingsuri}" />
</account>
EOS
  end

  def method_missing(sym, *args)
    return @hsh[sym] if @hsh.has_key?(sym)
    super
  end
end
