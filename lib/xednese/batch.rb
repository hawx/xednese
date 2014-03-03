class Esendex

  class Batch
    def initialize(credentials, response)
      @credentials = credentials
      @response = response
    end

    def name=(value)
      request = Requests::Batch.new(name: value)

      Client.put(@credentials, "v1.1/messagebatches/#{id}", request) do |status, data|
        value
      end
    end
  end
end
