require 'helper'

describe 'getting a batch' do
  let(:username) { String.generate }
  let(:password) { String.generate }
  subject { Esendex.new(username, password) }

  let(:batch) { Batch.generate }
  let(:response_body) { batch.to_xml }

  before {
    stub_request(:get, "https://#{username}:#{password}@api.esendex.com/v1.1/messagebatches/#{batch.id}?")
      .with(headers: {"User-Agent" => Esendex::Client::USER_AGENT})
      .to_return(status: 200, body: response_body)
  }

  it 'returns the specified message batch' do
    returned = subject.batches.get(batch.id)

    returned.id.must_equal batch.id
    returned.created_at.must_equal batch.created_at
    returned.batch_size.must_equal batch.batch_size
    returned.persisted_batch_size.must_equal batch.persisted_batch_size
    returned.account_reference.must_equal batch.account_reference
    returned.created_by.must_equal batch.created_by
    returned.name.must_equal batch.name
    returned.status.must_equal batch.status.status
  end
end
