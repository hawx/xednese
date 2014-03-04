require 'helper'

describe Esendex::Requests::Batch do
  subject { Esendex::Requests::Batch }

  describe '#serialise' do
    let(:new_name) { "what a name!" }

    it 'returns an xml representation of the instance' do
      batch = subject.new(name: new_name)

      batch.serialise.must_equal <<EOS
<?xml version="1.0" encoding="utf-8"?>
<messagebatch xmlns="http://api.esendex.com/ns/">
  <name>#{new_name}</name>
</messagebatch>
EOS
    end
  end
end
