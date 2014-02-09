require_relative 'helper'

describe Esendex do

  subject { dummy_esendex }
  let(:credentials) { subject.instance_variable_get(:@credentials) }

  describe '#accounts' do
    let(:account) { Object.new }

    it 'returns a new Accounts instance' do
      Esendex::Accounts
        .expects(:new)
        .with(credentials)
        .returns(account)

      subject.accounts.must_equal account
    end
  end

  describe '#dispatcher' do
    let(:dispatcher) { Object.new }

    it 'returns a new Dispatcher instance' do
      Esendex::Dispatcher
        .expects(:new)
        .with(credentials)
        .returns(dispatcher)

      subject.dispatcher.must_equal dispatcher
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
