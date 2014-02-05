class Esendex
  module Responses
    class Account
      extend Serialisable

      root 'account'

      attribute :id, 'id'
      attribute :uri, 'uri'

      element :reference, 'reference'
      element :label, 'label'
      element :address, 'address'
      element :type, 'type'
      element :messages_remaining, 'messagesremaining', Parser.for(&:to_i)
      element :expires_on, 'expireson'
      element :role, 'role'
      element :settings, Class.new {
        extend Serialisable
        root 'settings'
        attribute :uri, 'uri'
      }
    end
  end
end
