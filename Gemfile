source 'https://rubygems.org'
gem 'toml'
gem 'edn'
gem 'java-properties'
gem 'iniparse'
gem 'codeclimate-test-reporter', group: :test, require: nil
gem 'test-kitchen'
gem 'gherkin', '~> 5.1'

group :lint do
  gem 'rubocop', '~> 0.93.1'
  gem 'foodcritic'
end

group :unit, :integration do
  gem 'berkshelf'
  gem 'chefspec'
  gem 'serverspec'
end

group :development do
  gem 'awesome_print'
  gem 'github_changelog_generator'
  gem 'guard-kitchen'
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'rake'
  gem 'stove'
end

group :doc do
  gem 'yard'
end
