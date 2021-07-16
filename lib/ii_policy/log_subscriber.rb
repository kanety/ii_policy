# frozen_string_literal: true

module IIPolicy
  class LogSubscriber < ActiveSupport::LogSubscriber
    def call(event)
      debug do
        policy = event.payload[:policy]
        action = event.payload[:action]
        item = " for #{policy.item.class}##{policy.item.id}" if policy.item
        "Called #{policy.class}##{action}#{item} and return #{policy._result} (#{additional_log(event)})"
      end
    end

    def additional_log(event)
      additions = ["Duration: %.1fms" % event.duration]
      additions << "Allocations: %d" % event.allocations if event.respond_to?(:allocations)
      additions.join(', ')
    end
  end
end
