# frozen_string_literal: true

module IIPolicy
  module Chain
    extend ActiveSupport::Concern

    included do
      class_attribute :_chains
      self._chains = []
    end

    def call(action)
      lookup.each do |policy|
        return false unless policy.new(@context).call(action)
      end
      super
    end

    def lookup
      self.class._chains.map do |policy|
        if policy.is_a?(Symbol) && respond_to?(policy, true)
          send(policy)
        elsif policy.is_a?(Proc)
          instance_exec(&policy)
        else
          policy
        end
      end.flatten.compact
    end

    class_methods do
      def chain(*policies, &block)
        self._chains = _chains + policies
        self._chains << block if block
      end
    end
  end
end
