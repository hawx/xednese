require 'helper'

describe Esendex::Responses::Batch do
  describe '.deserialise' do
    let(:id) { "642A01A6-A483-44F3-A2F2-A48B1D0FE141" }
    let(:createdat) { "2012-01-01T12:00:00.000Z" }
    let(:batchsize) { 1 }
    let(:persistedbatchsize) { 1 }

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

    let(:accountreference) { "EX0000000" }
    let(:createdby) { "user@example.com" }
    let(:batch_name) { "hey my batch" }

    let(:xml) {
      <<EOS
<?xml version="1.0" encoding="utf-8"?>
<messagebatch id="#{id}"
   uri="https://api.esendex.com/v1.1/messagebatches/#{id}"
   xmlns="http://api.esendex.com/ns/">
  <createdat>#{createdat}</createdat>
  <batchsize>#{batchsize}</batchsize>
  <persistedbatchsize>#{persistedbatchsize}</persistedbatchsize>
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
  <accountreference>#{accountreference}</accountreference>
  <createdby>#{createdby}</createdby>
  <name>#{batch_name}</name>
</messagebatch>
EOS
    }

    it 'deserialises xml into a Batch instance' do
      batch = Esendex::Responses::Batch.deserialise(xml)

      batch.id.must_equal id
      batch.created_at.must_equal createdat
      batch.batch_size.must_equal batchsize
      batch.persisted_batch_size.must_equal persistedbatchsize

      batch.account_reference.must_equal accountreference
      batch.created_by.must_equal createdby
      batch.name.must_equal batch_name

      batch.status.acknowledged.must_equal acknowledged
      batch.status.authorisation_failed.must_equal authorisationfailed
      batch.status.connecting.must_equal connecting
      batch.status.delivered.must_equal delivered
      batch.status.failed.must_equal failed
      batch.status.partially_delivered.must_equal partiallydelivered
      batch.status.rejected.must_equal rejected
      batch.status.scheduled.must_equal scheduled
      batch.status.sent.must_equal sent
      batch.status.submitted.must_equal submitted
      batch.status.validity_period_expired.must_equal validityperiodexpired
      batch.status.cancelled.must_equal cancelled
    end
  end
end
