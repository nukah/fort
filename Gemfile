source 'http://rubygems.org'

# Project requirements
gem 'rake'
gem 'thin'
gem 'citadel', git: 'https://github.com/nukah/citadel.git'
gem 'bcrypt-ruby', :require => "bcrypt"
gem 'haml'
gem 'mongoid', '3.1.4'
gem 'oj'
gem 'coffee-script'
gem 'barista'
gem 'execjs'
gem 'tilt'
gem 'padrino-sprockets', :require => ['padrino/sprockets'], :git => 'git://github.com/nightsailer/padrino-sprockets.git'

# Padrino
gem 'padrino', git: "https://github.com/padrino/padrino-framework.git"
group :test do
  gem 'ladle'
  gem 'rspec'
  gem 'rack-test'
  gem 'rspec-given'
end

group :development, :test do
  gem 'shotgun'
  gem 'remote_table', git: 'https://github.com/seamusabshere/remote_table'
  gem 'rubyzip', '< 1.0.0'
  gem 'guard'

  gem 'jasmine-headless-webkit', '~> 0.9.0.rc1'
  gem 'guard-jasmine-headless-webkit', '~> 0.4.0.rc1'
  gem 'guard-rspec'

  gem 'growl'
  gem 'rb-fsevent'
end
