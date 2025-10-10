require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module KelasinBackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0
   

    config.autoload_lib(ignore: %w[assets tasks])
    config.api_only = true
    # Disable Action Cable completely (prevent cable DB connection)
    config.action_cable.mount_path = nil
    config.action_cable.url = nil
    config.action_cable.allowed_request_origins = []
    config.action_cable.disable_request_forgery_protection = true
    config.active_job.queue_adapter = :async

  end
end
