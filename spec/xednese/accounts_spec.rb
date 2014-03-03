require_relative '../helper'

describe Esendex::Accounts do
  let(:credentials) { dummy_credentials }
  subject { Esendex::Accounts.new(credentials) }

  describe '#each' do
    let(:data) { mock }
    let(:data_list) { [mock, mock] }
    let(:accounts) { stub(accounts: data_list) }
    let(:account_list) { [mock, mock] }

    before {
      Esendex::Client
        .expects(:get)
        .with(credentials, 'v1.0/accounts')
        .yields(200, data)
        .returns(account_list)

      Esendex::Responses::Accounts
        .expects(:deserialise)
        .with(data)
        .returns(accounts)

      accounts
        .expects(:accounts)
        .returns(data_list)

      data_list.zip(account_list).each do |d, a|
        Esendex::Account.expects(:new).with(credentials, d).returns(a)
      end
    }

    it 'retrieves all accounts' do
      returned_accounts = []
      subject.each do |account|
        returned_accounts << account
      end

      returned_accounts.must_equal account_list
    end
  end

  describe '#get' do
    let(:id)       { SecureRandom.uuid }
    let(:data)     { mock }
    let(:response) { mock }
    let(:account)  { mock }

    before {
      Esendex::Client
        .expects(:get)
        .with(credentials, "v1.0/accounts/#{id}")
        .yields(200, data)
        .returns(account)

      Esendex::Responses::Account
        .expects(:deserialise)
        .with(data)
        .returns(response)

      Esendex::Account
        .expects(:new)
        .with(credentials, response)
        .returns(account)
    }

    it 'retrieves the specified account' do
      subject.get(id).must_equal account
    end
  end
end
