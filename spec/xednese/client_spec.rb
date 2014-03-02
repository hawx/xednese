require_relative '../helper'

describe Esendex::Client do
  subject { Esendex::Client }

  describe '.get' do
    let(:credentials) { dummy_credentials }
    let(:path) { "some/url/path" }
    let(:args) { { query: "what", thing: "yep" } }

    let(:expected_code) { 418 }
    let(:expected_body) { "Hi I'm a body" }

    let(:uri) { mock }
    let(:form_params) { mock }
    let(:http) { mock }
    let(:get_request) { mock }

    before {
      URI.expects(:encode_www_form).with(args).returns(form_params)
      uri.expects(:query=).with(form_params)
      subject.expects(:url).with(path).returns(uri)

      subject
        .expects(:execute)
        .with(credentials, get_request)
        .returns([expected_code, expected_body])

      Net::HTTP::Get.expects(:new).with(uri).returns(get_request)
    }

    it 'returns the expected status code' do
      code, _ = subject.get(credentials, path, args)
      code.must_equal expected_code
    end

    it 'returns the expected body' do
      _, body = subject.get(credentials, path, args)
      body.must_equal expected_body
    end
  end

  describe '.post' do
    let(:credentials) { dummy_credentials }

    let(:path) { "some/url/path?query=yah" }

    let(:expected_code) { 418 }
    let(:expected_body) { "Hi I'm a body" }

    let(:xml) { "</xml>" }
    let(:serialisable_object) { stub(serialise: xml) }
    let(:post_request) { mock }

    before {
      subject
        .expects(:execute)
        .with(credentials, post_request)
        .returns([expected_code, expected_body])

      Net::HTTP::Post
        .expects(:new)
        .with(subject::ROOT + path)
        .returns(post_request)

      post_request
        .expects(:body=)
        .with(xml)

      post_request
        .expects(:content_type=)
        .with('application/xml')
    }

    it 'returns the expected status code' do
      code, _ = subject.post(credentials, path, serialisable_object)
      code.must_equal expected_code
    end

    it 'returns the expected body' do
      _, body = subject.post(credentials, path, serialisable_object)
      body.must_equal expected_body
    end
  end

  describe '.put' do
    let(:credentials) { dummy_credentials }

    let(:path) { "some/url/path?query=yah" }

    let(:expected_code) { 418 }
    let(:expected_body) { "Hi I'm a body" }

    let(:xml) { "</xml>" }
    let(:serialisable_object) { stub(serialise: xml) }
    let(:post_request) { mock }

    before {
      subject
        .expects(:execute)
        .with(credentials, post_request)
        .returns([expected_code, expected_body])

      Net::HTTP::Put
        .expects(:new)
        .with(subject::ROOT + path)
        .returns(post_request)

      post_request
        .expects(:body=)
        .with(xml)

      post_request
        .expects(:content_type=)
        .with('application/xml')
    }

    it 'returns the expected status code' do
      code, _ = subject.put(credentials, path, serialisable_object)
      code.must_equal expected_code
    end

    it 'returns the expected body' do
      _, body = subject.put(credentials, path, serialisable_object)
      body.must_equal expected_body
    end
  end

  describe '.execute' do
    let(:username) { 'myusername' }
    let(:password) { 'mypassword' }
    let(:credentials) { Esendex::Credentials.new(username, password, 'EX00') }

    let(:expected_code) { 418 }
    let(:expected_body) { "Hi I'm a body" }

    let(:http) { mock }
    let(:request) { mock }
    let(:response) { stub(body: expected_body, code: expected_code) }

    before {
      Net::HTTP
        .expects(:start)
        .with(subject::ROOT.host, subject::ROOT.port, use_ssl: true)
        .yields(http)
        .returns(expected_code, expected_body)

      request
        .expects(:[]=)
        .with("User-Agent", subject::USER_AGENT)

      request
        .expects(:basic_auth)
        .with(username, password)

      http
        .expects(:request)
        .with(request)
        .returns(response)
    }

    it 'returns the expected status code' do
      code, _ = subject.send(:execute, credentials, request)
      code.must_equal expected_code
    end

    it 'returns the expected body' do
      _, body = subject.send(:execute, credentials, request)
      body.must_equal expected_body
    end
  end
end
