class Esendex
  class Client
    ROOT = URI('https://api.esendex.com/')
    USER_AGENT = "ruby/xednese-0.0.0"
    CONTENT_TYPE = "application/xml"

    def self.get(credentials, path, args={})
      request = Net::HTTP::Get.new(url(path))

      code, body = execute(credentials, request)

      block_given? ? yield(code, body) : [code, body]
    end

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
