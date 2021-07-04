# frozen_string_literal: true

module IIPolicy
  module Chain
    extend ActiveSupport::Concern

    included do
      class_attribute :_chains
      self._chains = []
    end

    def call(action)
      self.class._chains.each do |policy|
        return false unless policy.new(@context).call(action)
      end
      super
    end

    class_methods do
      def chain(*policies)
        self._chains = _chains + policies
      end
    end
  end
end
