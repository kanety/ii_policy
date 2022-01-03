# frozen_string_literal: true

module IIPolicy
  module Contextualizer
    extend ActiveSupport::Concern
    include Coactive::Contextualizer

    def call(action)
      contextualize do
        super
      end
    end
  end
end
