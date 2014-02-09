require_relative '../helper'

describe Esendex::Users do
  let(:credentials) { Esendex::Credentials.new('user', 'pass', 'ref') }
  subject { Esendex::Users.new(credentials) }

end
