source "https://rubygems.org"

gem "rails", "~> 8.0.3"
gem "mysql2", "~> 0.5"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

# === Tambahkan di sini (di luar group development/test) ===
gem "bcrypt", "~> 3.1.7"
gem "jwt"
gem "rack-cors", require: "rack/cors"
gem "dotenv-rails"

# =========================================================

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end
