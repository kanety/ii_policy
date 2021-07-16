require_relative 'boot'

require 'action_controller/railtie'
require 'action_view/railtie'
require 'active_model/railtie'

Bundler.require(*Rails.groups)
require "ii_policy"

module Dummy
  class Application < Rails::Application
    config.after_initialize do
      IIPolicy::LogSubscriber.attach_to(:ii_policy)
    end
  end
end
