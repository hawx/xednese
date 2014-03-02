require_relative '../helper'

describe Esendex::Batches do
  let(:credentials) { dummy_credentials }
  subject { Esendex::Batches.new(credentials) }

  describe '#each' do
    let(:data) { mock }
    let(:batch_list) { [mock, mock] }
    let(:batches) { stub(batches: batch_list) }

    before {
      Esendex::Client
        .expects(:get)
        .with(credentials, 'v1.1/messagebatches')
        .yields(200, data)
        .returns(batch_list)

      Esendex::Responses::Batches
        .expects(:deserialise)
        .with(data)
        .returns(batches)

      batches.expects(:batches).returns(batches)
    }

    it 'retrieves all batches' do
      returned_batches = []
      subject.each do |batch|
        returned_batches << batch
      end

      returned_batches.must_equal batch_list
    end
  end

  describe '#get' do
    let(:id)    { "heyimanid" }
    let(:data)  { mock }
    let(:batch) { mock }

    before {
      Esendex::Client
        .expects(:get)
        .with(credentials, "v1.1/messagebatches/#{id}")
        .yields(200, data)
        .returns(batch)

      Esendex::Responses::Batch
        .expects(:deserialise)
        .with(data)
        .returns(batch)
    }

    it 'retrieves the specified message batch' do
      subject.get(id).must_equal batch
    end
  end
end
