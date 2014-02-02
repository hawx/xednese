# Xednese

``` ruby
require 'xednese'

esendex = Esendex.new('me@company.com', 'password', 'account reference')
p esendex.messages.sent.first.body
#=> "..."

response = esendex.dispatcher.send('Hey guys', '445275XXX')
p response.message_headers.map(&:id)
#=> ["..."]
```
