class Esendex
  class Batch
    PAGE_COUNT = 25

    # @see Esendex#batches
    # @api private
    def initialize(credentials, response)
      @credentials = credentials
      @response = response
    end

    extend Forwardable

    def_delegators :@response, :id, :created_at, :batch_size,
                   :persisted_batch_size, :account_reference, :created_by

    def status
      s = @response.status

      [:acknowledged,
       :authorisation_failed,
       :connecting,
       :delivered,
       :failed,
       :partially_delivered,
       :rejected,
       :scheduled,
       :sent,
       :submitted,
       :validity_period_expired,
       :cancelled].find do |type|
        s.send(type) == 1
      end
    end

    def name
      @name || @response.name
    end

    def name=(value)
      request = Requests::Batch.new(name: value)

      Client.put(@credentials, "v1.1/messagebatches/#{id}", request) do |status, data|
        @name = value
      end
    end

    def cancel!
      Client.delete(@credentials, "v1.1/messagebatches/#{id}/schedule")
    end

    # @return [Enumerable<Responses::MessageHeader>] an Enumerable that iterates
    #   over all messages in the batch. Requests are made for fixed size pages
    #   when required.
    def messages
      Seq::Paged.new do |page|
        params = {
          startIndex: PAGE_COUNT * page,
          count: PAGE_COUNT
        }

        Client.get(@credentials, "v1.0/messagebatches/#{id}/messages", params) do |status, data|
          Responses::MessageHeaders.deserialise(data).message_headers
        end
      end
    end
  end
end
