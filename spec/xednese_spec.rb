require_relative 'helper'

describe Esendex do

  subject { dummy_esendex }
  let(:credentials) { subject.instance_variable_get(:@credentials) }

  describe '#account' do
    let(:reference) { mock }
    let(:accounts)  { mock }

    describe 'when account exists' do
      let(:response)  { mock }
      let(:account)   { mock }

      before {
        Esendex::Accounts
          .expects(:new)
          .with(credentials)
          .returns(accounts)

        accounts
          .expects(:find)
          .returns(response)

        Esendex::Account
          .expects(:new)
          .with(credentials, response)
          .returns(account)
      }

      it 'returns the Account with that reference' do
        subject.account(reference).must_equal account
      end
    end

    describe 'when account does not exist' do
      before {
        Esendex::Accounts
          .expects(:new)
          .with(credentials)
          .returns(accounts)

        accounts
          .expects(:find)
          .returns(nil)
      }

      it 'is nil' do
        subject.account(reference).must_equal nil
      end
    end
  end

  describe '#accounts' do
    let(:accounts) { Object.new }

    it 'returns a new Accounts instance' do
      Esendex::Accounts
        .expects(:new)
        .with(credentials)
        .returns(accounts)

      subject.accounts.must_equal accounts
    end
  end

  describe '#messages' do
    let(:messages) { Object.new }

    it 'returns a new Messages instance' do
      Esendex::Messages
        .expects(:new)
        .with(credentials)
        .returns(messages)

      subject.messages.must_equal messages
    end
  end

  describe '#users' do
    let(:user) { Object.new }

    it 'returns a new Users instance' do
      Esendex::Users
        .expects(:new)
        .with(credentials)
        .returns(user)

      subject.users.must_equal user
    end
  end
end
