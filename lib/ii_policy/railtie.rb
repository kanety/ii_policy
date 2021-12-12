# frozen_string_literal: true

module IIPolicy
  class Railtie < Rails::Railtie
    ActiveSupport.on_load :action_controller do
      ActionController::Base.send :include, IIPolicy::Controller
    end

    ActiveSupport.on_load :action_view do
      ActionView::Base.send :include, IIPolicy::Helper
    end

    ActiveSupport::Reloader.to_prepare do
      IIPolicy::Lookup.cache.clear
    end
  end
end
