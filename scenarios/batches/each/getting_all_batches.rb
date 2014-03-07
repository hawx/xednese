require 'helper'

describe 'getting all of my batches' do
  let(:username) { String.generate }
  let(:password) { String.generate }
  subject { Esendex.new(username, password) }

  let(:batches) { Batches.generate(100) }
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

    returned_batches.size.must_equal 100

    returned_batches.zip(batches) do |returned, expected|
      returned.id.must_equal expected.id
    end
  end
end
