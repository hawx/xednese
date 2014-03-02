require_relative '../helper'

describe Esendex::Account do
  let(:id) { "D35FA8EB-3C12-4E8E-8DEC-8568B2F35890" }
  let(:credentials) { dummy_credentials }

  subject { Esendex::Account.new(credentials, id) }

  describe '#label=' do
    let(:new_label) { "this is my account" }
    let(:request) { mock }

    before {
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
  end
end
