require_relative '../../helper'

describe Esendex::Responses::Status do
  describe '.deserialise' do
    let(:acknowledged) { 0 }
    let(:authorisationfailed) { 0 }
    let(:connecting) { 0 }
    let(:delivered) { 0 }
    let(:failed) { 0 }
    let(:partiallydelivered) { 0 }
    let(:rejected) { 0 }
    let(:scheduled) { 0 }
    let(:sent) { 0 }
    let(:submitted) { 1 }
    let(:validityperiodexpired) { 0 }
    let(:cancelled) { 0 }

    let(:xml) {
      <<EOS
<?xml version="1.0" encoding="utf-8"?>
<status>
  <acknowledged>#{acknowledged}</acknowledged>
  <authorisationfailed>#{authorisationfailed}</authorisationfailed>
  <connecting>#{connecting}</connecting>
  <delivered>#{delivered}</delivered>
  <failed>#{failed}</failed>
  <partiallydelivered>#{partiallydelivered}</partiallydelivered>
  <rejected>#{rejected}</rejected>
  <scheduled>#{scheduled}</scheduled>
  <sent>#{sent}</sent>
  <submitted>#{submitted}</submitted>
  <validityperiodexpired>#{validityperiodexpired}</validityperiodexpired>
  <cancelled>#{cancelled}</cancelled>
</status>
EOS
    }

    it 'deserialises xml into a Status instance' do
      status = Esendex::Responses::Status.deserialise(xml)

      status.acknowledged.must_equal acknowledged
      status.authorisation_failed.must_equal authorisationfailed
      status.connecting.must_equal connecting
      status.delivered.must_equal delivered
      status.failed.must_equal failed
      status.partially_delivered.must_equal partiallydelivered
      status.rejected.must_equal rejected
      status.scheduled.must_equal scheduled
      status.sent.must_equal sent
      status.submitted.must_equal submitted
      status.validity_period_expired.must_equal validityperiodexpired
      status.cancelled.must_equal cancelled
    end
  end
end
