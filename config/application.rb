require_relative "boot"

require "rails/all"

if [ "development", "test" ].include? ENV["RAILS_ENV"]
  require "dotenv"
  Dotenv.load
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TestTwygoLms
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    config.time_zone = "Brasilia"
    config.eager_load_paths << Rails.root.join("lib")
    config.generators.system_tests = :rspec

    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**/*.{rb,yml}")]
    config.i18n.available_locales = [ :en, "pt-BR" ]
    config.i18n.default_locale = "pt-BR"
  end
end
