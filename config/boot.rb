ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
require_relative '../lib/server_runtime'
require 'log4r'
require 'log4r/outputter/datefileoutputter'

