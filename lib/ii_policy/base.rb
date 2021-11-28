# frozen_string_literal: true

require_relative 'context'
require_relative 'core'
require_relative 'callbacks'
require_relative 'instrumentation'
require_relative 'lookup'
require_relative 'coactors'

module IIPolicy
  class Base
    include Core
    include Callbacks
    include Instrumentation
    include Lookup
    include Coactors
  end
end
