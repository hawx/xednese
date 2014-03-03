require_relative '../helper'

describe Esendex::Batch do
  let(:credentials) { dummy_credentials }
  let(:response) { mock }
  subject { Esendex::Batch.new(credentials, response) }

  [:id, :created_at, :batch_size, :persisted_batch_size,
   :account_reference, :created_by, :name].each do |thing|
    describe "##{thing}" do
      before {
        @value = mock
        response.expects(thing).returns(@value)
      }

      it "returns the #{thing} from the response" do
        subject.send(thing).must_equal @value
      end
    end
  end

  describe '#status' do
    let(:status) { mock(acknowledged: 0,
                        authorisation_failed: 0,
                        connecting: 0,
                        delivered: 0,
                        failed: 0,
                        partially_delivered: 0,
                        rejected: 0,
                        scheduled: 0,
                        sent: 0,
                        submitted: 0,
                        validity_period_expired: 0,
                        cancelled: 1) }

    before {
      response.expects(:status).returns(status)
    }

    it 'returns the status that is set to 1' do
      subject.status.must_equal :cancelled
    end
  end

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

    it 'makes #name return the new name' do
      subject.name = new_name
      subject.name.must_equal new_name
    end
  end

  describe '#cancel!' do
    let(:id)      { SecureRandom.uuid }
    let(:request) { mock }

    before {
      subject.expects(:id).returns(id)

      Esendex::Client
        .expects(:delete)
        .with(credentials, "v1.1/messagebatches/#{id}/schedule")
        .yields(204)
    }

    it 'cancels the message batch' do
      subject.cancel!
    end
  end
end
