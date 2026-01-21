# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = Rails.application.credentials.sentry_key!

  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  config.before_send_transaction = lambda do |event, _hint|
    return if event.transaction == "Rails::HealthController#show"

    event
  end

  config.enabled_environments = ["production"]
end
