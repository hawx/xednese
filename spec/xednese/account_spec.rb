require 'helper'

describe Esendex::Account do
  let(:response)   { mock }
  let(:credentials) { dummy_credentials }
  subject { Esendex::Account.new(credentials, response) }

  [:id, :reference, :address, :messages_remaining,
   :type, :expires_on, :role].each do |value|
    describe "##{value}" do
      before     {
        @value = mock
        response.expects(value).returns(@value)
      }

      it "returns the #{value} from the response" do
        subject.send(value).must_equal @value
      end
    end
  end

  describe '#label' do
    let(:label) { mock }
    before      { response.expects(:label).returns(label) }

    it 'returns the label from the response' do
      subject.label.must_equal label
    end
  end

  describe '#label=' do
    let(:id)        { "587329572387275372" }
    let(:new_label) { "this is my account" }
    let(:request)   { mock }

    before {
      subject
        .expects(:id)
        .returns(id)

      Esendex::Requests::Account
        .expects(:new)
        .with(label: new_label)
        .returns(request)

      Esendex::Client
        .expects(:put)
        .with(credentials, "v1.0/accounts/#{id}", request)
        .yields(200)
    }

    it 'sets the label for the account' do
      (subject.label = new_label).must_equal new_label
    end

    it 'makes #label return the new label' do
      subject.label = new_label
      subject.label.must_equal new_label
    end
  end

  describe '#dispatcher' do
    let(:reference)  { mock }
    let(:dispatcher) { mock }

    it 'returns a new Dispatcher instance' do
      subject.expects(:reference).returns(reference)

      Esendex::Account::Dispatcher
        .expects(:new)
        .with(credentials, reference)
        .returns(dispatcher)

      subject.dispatcher.must_equal dispatcher
    end
  end

  describe '#messages' do
    let(:reference) { mock }
    let(:messages)  { mock }

    it 'returns a new Messages instance' do
      subject.expects(:reference).returns(reference)

      Esendex::Account::Messages
        .expects(:new)
        .with(credentials, reference)
        .returns(messages)

      subject.messages.must_equal messages
    end
  end
end
