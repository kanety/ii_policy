# frozen_string_literal: true

module IIPolicy
  module Instrumentation
    extend ActiveSupport::Concern

    def call_all(action)
      ActiveSupport::Notifications.instrument 'start_call_all.ii_policy', policy: self, action: action
      super
    end

    def call(action)
      ActiveSupport::Notifications.instrument 'process_call.ii_policy', policy: self, action: action do
        super
      end
    end
  end
end
