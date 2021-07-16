# frozen_string_literal: true

module IIPolicy
  module Core
    extend ActiveSupport::Concern

    included do
      attr_reader :context, :user, :item, :_result
    end

    def initialize(context = {})
      @context = if context.is_a?(IIPolicy::Context)
          context
        else
          IIPolicy::Context.new(context)
        end
      @item = @context.item
      @user = @context.user
    end

    def call(action)
      if respond_to?(action) && !send(action)
        @_result = false
      else
        @_result = true
      end
    end

    def allowed(action)
      call(action)
    end

    def policy(item)
      context = @context.dup
      context.item = item
      self.class.lookup(item).new(context)
    end
  end
end
