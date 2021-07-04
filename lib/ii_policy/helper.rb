# frozen_string_literal: true

module IIPolicy
  module Helper
    delegate :policy, to: :controller
  end
end
