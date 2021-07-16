# frozen_string_literal: true

module IIPolicy
  module Lookup
    extend ActiveSupport::Concern

    class_methods do
      def lookup(klass)
        Lookup.call(klass)
      end
    end

    class << self
      class_attribute :cache
      self.cache = {}

      def call(klass)
        klass = klass.class unless klass.is_a?(Module)
        return if terminate?(klass)

        with_cache(klass) do
          if klass.name && (policy = resolve(klass))
            policy
          elsif klass.superclass
            call(klass.superclass)
          end
        end
      end

      private

      def with_cache(klass)
        if Config.lookup_cache
          self.cache[klass] ||= yield
        else
          yield
        end
      end

      def terminate?(klass)
        klass.name.to_s.in?(['Object', 'ActiveRecord::Base', 'ActiveModel::Base', 'ActionController::Base'])
      end

      def resolve(klass)
        policy_name = if klass < ActionController::Base
            "#{klass.name.sub(/Controller$/, '').singularize}Policy"
          else
            "#{klass.name}Policy"
          end
        policy = policy_name.safe_constantize
        return policy if policy && policy_name == policy.name
      end
    end
  end
end
