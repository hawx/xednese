require_relative '../../helper'

describe Esendex::Requests::Account do
  subject { Esendex::Requests::Account }

  describe '#serialise' do
    let(:label) { "what a label?" }

    it 'returns an xml representation of the instance' do
      account = subject.new(label: label)

      account.serialise.must_equal <<EOS
<?xml version="1.0" encoding="utf-8"?>
<account xmlns="http://api.esendex.com/ns/">
  <label>#{label}</label>
</account>
EOS
    end
  end
end
