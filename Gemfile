source :rubygems

group :default do
  gem 'rails',            '>= 3.1'
  gem 'sugar-high',       '>= 0.6'
  gem 'sweetloader',      '>= 0.1.6'
  gem 'hashie',           '>= 1.2'
  
  gem 'cantango-config',  '~> 0.2.1', :git => 'git://github.com/kristianmandrup/cantango-config.git'
  gem 'cantango-api',     '>= 0.1.3'
end

group :development do
  gem "bundler",    ">= 1.1"
  gem "jeweler",    ">= 1.8.4"
  gem "simplecov",  ">= 0.5"
end

group :test do
  gem 'require_all', '~> 1.2.0'

  gem 'generator-spec'

  gem 'forgery'
  gem 'sqlite3'
  # Data
  gem 'database_cleaner'
  gem 'factory_girl'

  # Specs
  gem 'spork'

  # Debug and performance tests
  gem 'cutter'
end

group :test, :development do
  gem "rspec",    ">= 2.8.0"
end
