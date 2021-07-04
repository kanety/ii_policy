# frozen_string_literal: true

require_relative 'context'
require_relative 'callbacks'
require_relative 'lookup'
require_relative 'chain'

module IIPolicy
  class Base
    include Callbacks
    include Lookup

    attr_reader :context, :user, :item

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
      run_callbacks(:call) do
        return false if respond_to?(action) && !send(action)
      end
      return true
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
