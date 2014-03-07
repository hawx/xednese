class Accounts < Array
  def self.generate(n)
    new (0...n).map { Account.generate }
  end

  def to_xml
    str = <<EOS
<?xml version="1.0" encoding="utf-8"?>
<accounts xmlns="http://api.esendex.com/ns/">
EOS

    each do |account|
      str += <<EOS
<account id="#{account.id}" uri="#{account.uri}">
  <reference>#{account.reference}</reference>
  <label>#{account.label}</label>
  <address>#{account.address}</address>
  <type>#{account.type}</type>
  <messagesremaining>#{account.messagesremaining}</messagesremaining>
  <expireson>#{account.expireson}</expireson>
  <role>#{account.role}</role>
  <settings uri="#{account.settingsuri}" />
</account>
EOS
    end

    return str + "</accounts>"
  end
end
