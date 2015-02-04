require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Invint
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.active_record.pluralize_table_names = false

    # Set up the cache and its log
    config.cache_store = ActiveSupport::Cache.lookup_store :memory_store
    config.cache_store.logger = Log4r::Logger.new('invint_cache')
    config.cache_store.logger.level = Log4r::DEBUG
    config.cache_store.logger.outputters << Log4r::DateFileOutputter.new(
      'outputter',
      {
        dirname: "#{Rails.root}/log",
        filename: 'cache.log',
        formatter: Log4r::PatternFormatter.new(:pattern => '[%d] [%l] %m'),
        level: config.cache_store.logger.level
      })
  end
end
