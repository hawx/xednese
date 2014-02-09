require_relative '../helper'

describe Esendex::Accounts do
  let(:credentials) { Esendex::Credentials.new('user', 'pass', 'ref') }
  subject { Esendex::Accounts.new(credentials) }

  describe '#each' do
    let(:data) { mock }
    let(:account_list) { [mock, mock] }
    let(:accounts) { stub(accounts: account_list) }

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
        .returns(account_list)
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
    let(:id) { "heyohid" }
    let(:data) { mock }
    let(:account) { mock }

    before {
      Esendex::Client
        .expects(:get)
        .with(credentials, "v1.0/accounts/#{id}")
        .yields(200, data)
        .returns(account)

      Esendex::Responses::Account
        .expects(:deserialise)
        .with(data)
        .returns(account)
    }

    it 'retrieves the specified accounts' do
      subject.get(id).must_equal account
    end
  end
end
