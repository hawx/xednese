class Esendex
  module Responses
    class Status
      extend Serialisable

      root 'status'

      element :acknowledged, 'acknowledged', :to_i
      element :authorisation_failed, 'authorisationfailed', :to_i
      element :connecting, 'connecting', :to_i
      element :delivered, 'delivered', :to_i
      element :failed, 'failed', :to_i
      element :partially_delivered, 'partiallydelivered', :to_i
      element :rejected, 'rejected', :to_i
      element :scheduled, 'scheduled', :to_i
      element :sent, 'sent', :to_i
      element :submitted, 'submitted', :to_i
      element :validity_period_expired, 'validityperiodexpired', :to_i
      element :cancelled, 'cancelled', :to_i
    end
  end
end
