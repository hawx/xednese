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

Xednese is a client library for interacting with the
[Esendex REST API][exapi]. It is currently under active development and should
not be considered stable enough for general use.


## Running locally

Clone the repo, then to run the tests:

``` bash
$ gen install bundler
$ bundle install
$ bundle exec rake
...
```

[exapi]: developers.esendex.com/APIs/REST-API/
