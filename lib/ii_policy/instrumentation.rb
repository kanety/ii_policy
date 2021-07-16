# frozen_string_literal: true

module IIPolicy
  module Instrumentation
    extend ActiveSupport::Concern

    def call(action)
      ActiveSupport::Notifications.instrument 'call.ii_policy', policy: self, action: action do
        super
      end
    end
  end
end
