# frozen_string_literal: true

module IIPolicy
  class LogSubscriber < ActiveSupport::LogSubscriber
    def calling(event)
      debug do
        policy = event.payload[:policy]
        action = event.payload[:action]
        "Calling #{policy.class}##{action} with #{policy.context}"
      end
    end

    def call(event)
      debug do
        policy = event.payload[:policy]
        action = event.payload[:action]
        "Called #{policy.class}##{action} and return #{policy._result} (#{additional_log(event)})"
      end
    end

    private

    def additional_log(event)
      additions = ["Duration: %.1fms" % event.duration]
      additions << "Allocations: %d" % event.allocations if event.respond_to?(:allocations)
      additions.join(', ')
    end
  end
end
