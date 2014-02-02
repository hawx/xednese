class Esendex
  module Responses
    class MessageDispatcherHeaders
      extend Serialisable

      root 'messageheaders'

      attribute :batch_id, 'batchid'
      elements :message_headers, Class.new {
        extend Serialisable

        root 'messageheader'
        attribute :uri, 'uri'
        attribute :id, 'id'
      }
    end
  end
end
