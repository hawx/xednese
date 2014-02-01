class Esendex
  module Responses
    class MessageHeaders
      extend Serialisable

      root 'messageheaders'

      attribute :start_index, 'startindex', Parser.for(&:to_i)
      attribute :count,       'count',      Parser.for(&:to_i)
      attribute :total_count, 'totalcount', Parser.for(&:to_i)

      elements :message_headers, MessageHeader
    end
  end
end
