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
      planned = case IIPolicy.config.traversal
        when :preorder
          [self] + coactors
        when :postorder
          coactors + [self]
        when :inorder
          planned = coactors.in_groups(2, false)
          planned[0] + [self] + planned[1]
        end

      planned.each do |policy|
        result = policy == self ? call(action) : policy.new(@context).call_all(action)
        return false unless result
      end

      return true
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
