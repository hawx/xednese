require 'net/http'

class Esendex
  class Client
    ROOT = URI('https://api.esendex.com/')

    def self.get(credentials, path, args={})
      code = 0
      body = ""

      request = Net::HTTP::Get.new(URI.join(ROOT.to_s, path))
      request["User-Agent"] = "ruby/xednese-0.0.0"
      request.basic_auth credentials.username, credentials.password

      Net::HTTP.start(ROOT.host, ROOT.port, use_ssl: true) do |http|
        resp = http.request(request)
        code = resp.code
        body = resp.body
      end

      block_given? ? yield(code, body) : [code, body]
    end
  end
end
