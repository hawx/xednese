require 'helper'

describe 'getting all of my batches' do
  let(:username) { String.generate }
  let(:password) { String.generate }
  subject { Esendex.new(username, password) }

  let(:count) { 40 }
  let(:batches) { Batches.generate(count) }
  let(:response_body) { batches.to_xml }

  before {
    stub_request(:get, "https://#{username}:#{password}@api.esendex.com/v1.1/messagebatches?")
      .with(query: {"count" => 25, "startIndex" => 0},
            headers: {"User-Agent" => Esendex::Client::USER_AGENT})
      .to_return(status: 200, body: response_body)

    stub_request(:get, "https://#{username}:#{password}@api.esendex.com/v1.1/messagebatches?")
      .with(query: {"count" => 25, "startIndex" => 25},
            headers: {"User-Agent" => Esendex::Client::USER_AGENT})
      .to_return(status: 200, body: Batches.generate(0).to_xml)
  }

  it 'returns an Enumerable that iterates over my batches' do
    returned_batches = subject.batches.entries

    returned_batches.size.must_equal count

    returned_batches.zip(batches) do |returned, expected|
      returned.id.must_equal expected.id
      returned.created_at.must_equal expected.created_at
      returned.batch_size.must_equal expected.batch_size
      returned.persisted_batch_size.must_equal expected.persisted_batch_size
      returned.status.must_equal expected.status.status
      returned.account_reference.must_equal expected.account_reference
      returned.created_by.must_equal expected.created_by
      returned.name.must_equal expected.name
    end
  end
end
