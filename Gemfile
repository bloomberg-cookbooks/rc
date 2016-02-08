source 'https://rubygems.org'
gem 'poise', '~> 2.2'
gem 'poise-boiler'
gem 'toml'
gem 'edn'
gem 'java-properties'
gem 'iniparse'
gem 'codeclimate-test-reporter', group: :test, require: nil

group :lint do
  gem 'rubocop'
  gem 'foodcritic'
end

group :unit, :integration do
  gem 'berkshelf'
  gem 'chefspec'
  gem 'serverspec'
end

group :development do
  gem 'awesome_print'
  gem 'guard-kitchen'
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'rake'
  gem 'stove'
end

group :doc do
  gem 'yard'
end
