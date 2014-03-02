class Esendex
  module Responses
    class Batch
      extend Serialisable

      root 'messagebatch'

      attribute :id, 'id'

      element :created_at, 'createdat'
      element :batch_size, 'batchsize', :to_i
      element :persisted_batch_size, 'persistedbatchsize', :to_i
      element :account_reference, 'accountreference'
      element :created_by, 'createdby'
      element :name, 'name'

      element :status, Status
    end
  end
end
