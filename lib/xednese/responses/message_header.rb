class Esendex
  module Responses
    class MessageHeader
      extend Serialisable

      root 'messageheader'

      attribute :id, 'id'
      attribute :uri, 'uri'

      element :status,       'status'
      element :last_status_at, 'laststatusat', Time
      element :submitted_at,  'submittedat', Time
      element :type,         'type'
      element :to,           Class.new { extend Serialisable
        root 'to'
        element :phonenumber, 'phonenumber'
      }
      element :from,         Class.new { extend Serialisable
        root 'from'
        element :phonenumber, 'phonenumber'
      }
      element :summary,      'summary'
      element :body,         Class.new { extend Serialisable
        root 'body'
        attribute :uri, 'uri'
      }
      element :direction,    'direction'
      element :parts,        'parts', Parser.for(&:to_i)
      element :username,     'username'
    end
  end
end
