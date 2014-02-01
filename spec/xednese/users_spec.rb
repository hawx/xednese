require_relative '../helper'

describe Esendex::Users do
  let(:credentials) { Esendex::Credentials.new('user', 'pass', 'ref') }
  subject { Esendex::Users.new(credentials) }

  describe '#username' do
    it 'returns the username' do
      subject.username.must_equal credentials.username
    end
  end

  describe '#password' do
    it 'returns the password' do
      subject.password.must_equal credentials.password
    end
  end
end
