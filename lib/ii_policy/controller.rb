# frozen_string_literal: true

module IIPolicy
  module Controller
    extend ActiveSupport::Concern

    def policy_context
      { user: current_user }
    end

    def policy(item, context = {})
      if item.is_a?(Class) && item < IIPolicy::Base
        item.new(policy_context.merge(context))
      else
        klass = IIPolicy::Base.lookup(item)
        raise IIPolicy::Error.new("could not find policy for #{item}") unless klass
        klass.new(policy_context.merge(context.merge(item: item)))
      end
    end

    def authorize(item, context = {})
      instance = policy(item, context)
      raise IIPolicy::AuthorizationError.new('Not Authorized') unless instance.allowed("#{action_name}?")
      instance
    end
  end
end
