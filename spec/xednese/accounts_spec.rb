require_relative '../helper'

describe Esendex::Accounts do
  let(:credentials) { Esendex::Credentials.new('user', 'pass', 'ref') }
  subject { Esendex::Accounts.new(credentials) }

  describe '#reference' do
    it 'returns the account reference' do
      subject.reference.must_equal credentials.account_reference
    end
  end
end
