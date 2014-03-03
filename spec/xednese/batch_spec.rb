require_relative '../helper'

describe Esendex::Batch do
  let(:credentials) { dummy_credentials }
  let(:response) { mock }
  subject { Esendex::Batch.new(credentials, response) }

  describe '#name=' do
    let(:id)       { SecureRandom.uuid }
    let(:new_name) { "this is my batch" }
    let(:request)  { mock }

    before {
      subject
        .expects(:id)
        .returns(id)

      Esendex::Requests::Batch
        .expects(:new)
        .with(name: new_name)
        .returns(request)

      Esendex::Client
        .expects(:put)
        .with(credentials, "v1.1/messagebatches/#{id}", request)
        .yields(204)
    }

    it 'sets the name of the batch' do
      (subject.name = new_name).must_equal new_name
    end
  end
end
