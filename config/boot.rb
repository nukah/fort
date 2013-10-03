# Defines our constants
PADRINO_ENV  = ENV['PADRINO_ENV'] ||= ENV['RACK_ENV'] ||= 'development'  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, PADRINO_ENV)
require 'gollum/app'

##
# Add here your before load hooks
#
Padrino.before_load do
  I18n.locale = :ru
  I18n.default_locale = :ru
end

##
# Add here your after load hooks
#
Padrino.after_load do
  Mongoid.load!(File.join(PADRINO_ROOT, 'mongoid.yml'), :production)
end

Padrino.load!
