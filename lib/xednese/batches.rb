class Esendex

  # Provides methods for working with message batches. A Batches instance is
  # Enumerable, and will only make requests when needed.
  class Batches

    # @see Esendex#batches
    # @api private
    def initialize(credentials)
      @credentials = credentials
    end

    # @yield [Batch] Calls the provided block with each batch the user has
    # access to
    def each(&block)
      Client.get(@credentials, 'v1.1/messagebatches') {|status, data|
        Responses::Batches.deserialise(data).batches.map do |batch|
          Batch.new(@credentials, batch)
        end
      }.each(&block)
    end

    include Enumerable

    # @param id [String] the id of the batch to return
    # @return [Batch] Returns the batch with the given id.
    def get(id)
      Client.get(@credentials, "v1.1/messagebatches/#{id}") do |status, data|
        Batch.new @credentials, Responses::Batch.deserialise(data)
      end
    end
  end
end
