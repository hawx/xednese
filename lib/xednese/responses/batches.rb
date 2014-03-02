class Esendex
  module Responses
    class Batches
      extend Serialisable

      root 'messagebatches'

      attribute :start_index, 'startindex', :to_i
      attribute :count,       'count',      :to_i
      attribute :total_count, 'totalcount', :to_i

      elements :batches, Batch
    end
  end
end
