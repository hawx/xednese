class Esendex

  # Client is a wrapper for Net::HTTP for calling through to the Esendex REST
  # API.
  class Client
    ROOT = URI('https://api.esendex.com/')
    USER_AGENT = "ruby/xednese-#{VERSION}"
    CONTENT_TYPE = "application/xml"

    # @param credentials [Credentials]
    # @param path [String] Path to GET (after the api.esendex.com/ part)
    # @param args [Hash] An optional hash of query parameters to be appended to
    #   the url.
    #
    # @return [Integer, String] Returns the status code and the response body.
    def self.get(credentials, path, args={})
      uri = url(path)
      uri.query = URI.encode_www_form(args)
      request = Net::HTTP::Get.new(uri)

      code, body = execute(credentials, request)

      block_given? ? yield(code, body) : [code, body]
    end

    # @param credentials [Credentials]
    # @param path [String] Path to POST to
    # @param object [#serialise] The object that represents the content to be
    #   posted. This must be an object with a method #serialise that returns a
    #   string of xml.
    #
    # @return [Integer, String] Returns the status code and the response body.
    def self.post(credentials, path, object)
      request = Net::HTTP::Post.new(url(path))
      request.body = object.serialise
      request.content_type = CONTENT_TYPE

      code, body = execute(credentials, request)

      block_given? ? yield(code, body) : [code, body]
    end

    private

    def self.url(path)
      URI.join(ROOT.to_s, path)
    end

    def self.execute(credentials, request)
      request["User-Agent"] = USER_AGENT
      request.basic_auth credentials.username, credentials.password

      code, body = nil, nil

      Net::HTTP.start(ROOT.host, ROOT.port, use_ssl: true) do |http|
        resp = http.request(request)
        code = resp.code
        body = resp.body
      end

      [code, body]
    end
  end
end
