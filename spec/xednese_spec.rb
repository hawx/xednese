require_relative 'helper'

describe Esendex do

  subject { dummy_esendex }
  let(:credentials) { subject.instance_variable_get(:@credentials) }

  describe '#account' do
    describe 'when account exists' do
      let(:reference) { mock }
      let(:account)   { mock(reference: reference) }
      let(:accounts)  { [stub(reference: mock),
                         stub(reference: mock),
                         account,
                         stub(reference: mock)] }

      before {
        Esendex::Accounts
          .expects(:new)
          .with(credentials)
          .returns(accounts)
      }

      it 'returns the Account with that reference' do
        subject.account(reference).must_equal account
      end
    end

    describe 'when account does not exist' do
      let(:reference) { mock }
      let(:accounts)  { [stub(reference: mock),
                         stub(reference: mock),
                         stub(reference: mock)] }

      before {
        Esendex::Accounts
          .expects(:new)
          .with(credentials)
          .returns(accounts)
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

  describe '#batches' do
    let(:batches) { mock }

    it 'returns a new Batches instance' do
      Esendex::Batches
        .expects(:new)
        .with(credentials)
        .returns(batches)

      subject.batches.must_equal batches
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
