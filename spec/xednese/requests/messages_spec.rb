require_relative '../../helper'

describe Esendex::Requests::Messages do
  subject { Esendex::Requests::Messages }

  describe '#serialise' do
    let(:reference) { 'EX0000' }
    let(:first) { { to: 'someone', body: 'yo' } }
    let(:second) { { to: 'other', body: 'what?' } }

    it 'returns an xml representation of the instance' do
      messages = subject.new({
        account_reference: reference,
        messages: [first, second]
      })

      messages.serialise.must_equal <<EOS
<?xml version="1.0" encoding="utf-8"?>
<messages>
  <accountreference>#{reference}</accountreference>
  <message>
    <to>#{first[:to]}</to>
    <body>#{first[:body]}</body>
  </message>
  <message>
    <to>#{second[:to]}</to>
    <body>#{second[:body]}</body>
  </message>
</messages>
EOS
    end
  end
end
