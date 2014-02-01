require 'seq/paged'
require 'serialisable'
require 'time'

class Esendex
  class Messages
    def initialize(credentials)
      @credentials = credentials
    end

    def sent
      Seq::Paged.new do |page|
        Client.get(@credentials, 'v1.0/messageheaders', page: page) do |status, data|
          Responses::MessageHeaders.deserialise(data).messageheaders
        end
      end
    end

    def get(id)
      Client.get(@credentials, "v1.0/messageheaders/#{id}") do |status, data|
        Responses::MessageHeader.deserialise(data)
      end
    end

    module Responses
      class Body
        extend Serialisable

        root 'body'
        attribute :uri, 'uri'
      end

      class To
        extend Serialisable

        root 'to'
        element :phonenumber, 'phonenumber'
      end

      class From
        extend Serialisable

        root 'from'
        element :phonenumber, 'phonenumber'
      end

      class MessageHeader
        extend Serialisable

        root 'messageheader'

        attribute :id, 'id'
        attribute :uri, 'uri'

        element :status,       'status'
        element :laststatusat, 'laststatusat', Time
        element :submittedat,  'submittedat', Time
        element :type,         'type'
        element :to,           To
        element :from,         From
        element :summary,      'summary'
        element :body,         Body
        element :direction,    'direction'
        element :reference,    'reference'
        element :parts,        'parts'
        element :username,     'username'
      end

      class MessageHeaders
        extend Serialisable

        root 'messageheaders'
        elements :messageheaders, MessageHeader
      end
    end
  end
end
