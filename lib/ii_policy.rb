# frozen_string_literal: true

require 'active_support'
require 'coactive'

require 'ii_policy/version'
require 'ii_policy/config'
require 'ii_policy/errors'
require 'ii_policy/base'
require 'ii_policy/controller'
require 'ii_policy/helper'
require 'ii_policy/log_subscriber'
require 'ii_policy/railtie' if defined?(Rails)

module IIPolicy
  class << self
    def configure
      yield Config
    end

    def config
      Config
    end
  end
end
