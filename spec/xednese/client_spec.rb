require_relative '../helper'

describe Esendex::Client do
  describe '.get' do
    let(:username) { 'myusername' }
    let(:password) { 'mypassword' }
    let(:credentials) { Esendex::Credentials.new(username, password, 'EX00') }

    let(:path) { "some/url/path?query=yah" }

    let(:expected_code) { 418 }
    let(:expected_body) { "Hi I'm a body" }

    let(:http) { mock }
    let(:get_request) { mock }
    let(:response) { stub(:response_body_permitted? => true,
                          :body => expected_body,
                          :code => expected_code) }

    before {
      Net::HTTP
        .expects(:start)
        .with(Esendex::Client::ROOT.host, Esendex::Client::ROOT.port, use_ssl: true)
        .yields(http)
        .returns(expected_code, expected_body)

      Net::HTTP::Get
        .expects(:new)
        .with(Esendex::Client::ROOT + path)
        .returns(get_request)

      get_request
        .expects(:[]=)
        .with("User-Agent", "ruby/xednese-0.0.0")

      get_request
        .expects(:basic_auth)
        .with(username, password)

      http
        .expects(:request)
        .with(get_request)
        .returns(response)
    }

    it 'returns the expected status code' do
      code, _ = Esendex::Client.get(credentials, path)
      code.must_equal expected_code
    end

    it 'returns the expected body' do
      _, body = Esendex::Client.get(credentials, path)
      body.must_equal expected_body
    end
  end
end
