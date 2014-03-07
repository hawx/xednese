class Batch
  def self.generate
    new id: Guid.generate,
        uri: Uri.generate,
        created_at: Time.generate.format,
        batch_size: Int.generate,
        persisted_batch_size: Int.generate,
        account_reference: AccountReference.generate,
        created_by: String.generate,
        name: String.generate,
        status: Status.generate
  end

  def initialize(hsh)
    @hsh = hsh
  end

  def to_xml
    <<EOS
<?xml version="1.0" encoding="utf-8"?>
<messagebatch id="#{id}"
   uri="#{uri}"
   xmlns="http://api.esendex.com/ns/">
  <createdat>#{created_at}</createdat>
  <batchsize>#{batch_size}</batchsize>
  <persistedbatchsize>#{persisted_batch_size}</persistedbatchsize>
  #{status.to_xml}
  <accountreference>#{account_reference}</accountreference>
  <createdby>#{created_by}</createdby>
  <name>#{name}</name>
</messagebatch>
EOS
  end

  def method_missing(sym, *args)
    return @hsh[sym] if @hsh.has_key?(sym)
    super
  end
end

class Status
  def self.generate
    new acknowledged: 0,
        authorisation_failed: 0,
        connecting: 0,
        delivered: 0,
        failed: 0,
        partially_delivered: 0,
        rejected: 1,
        scheduled: 0,
        sent: 0,
        submitted: 0,
        validity_period_expired: 0,
        cancelled: 0
  end

  def initialize(hsh)
    @hsh = hsh
  end

  # ugh
  def status
    :rejected
  end

  def to_xml
    <<EOS
  <status>
    <acknowledged>#{acknowledged}</acknowledged>
    <authorisationfailed>#{authorisation_failed}</authorisationfailed>
    <connecting>#{connecting}</connecting>
    <delivered>#{delivered}</delivered>
    <failed>#{failed}</failed>
    <partiallydelivered>#{partially_delivered}</partiallydelivered>
    <rejected>#{rejected}</rejected>
    <scheduled>#{scheduled}</scheduled>
    <sent>#{sent}</sent>
    <submitted>#{submitted}</submitted>
    <validityperiodexpired>#{validity_period_expired}</validityperiodexpired>
    <cancelled>#{cancelled}</cancelled>
  </status>
EOS
  end

  def method_missing(sym, *args)
    return @hsh[sym] if @hsh.has_key?(sym)
    super
  end
end
