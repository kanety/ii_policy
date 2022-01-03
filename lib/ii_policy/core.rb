# frozen_string_literal: true

module IIPolicy
  module Core
    extend ActiveSupport::Concern
    include Coactive::Initializer

    included do
      self.context_class = IIPolicy::Context
      context :user, :item
      attr_reader :_result
    end

    def initialize(args = {})
      super
    end

    def call_all(action)
      coactors.each do |policy|
        return false unless policy.new(@context).call_all(action)
      end
      call(action)
    end

    def call(action)
      if respond_to?(action) && !send(action)
        @_result = false
      else
        @_result = true
      end
    end

    def allowed(action)
      call_all(action)
    end

    def policy(item)
      context = self.class.context_class.new(@context.to_h.dup.merge(item: item))
      self.class.lookup(item).new(context)
    end
  end
end
