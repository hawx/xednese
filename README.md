# Xednese

``` ruby
require 'xednese'

esendex = Esendex.new('me@company.com', 'password')
p esendex.messages.sent.first.summary
#=> "..."

account = esendex.account("EX0000")
response = account.dispatcher.send('Hey guys', '445275XXX')
p response.message_headers.map(&:id)
#=> ["..."]
```
