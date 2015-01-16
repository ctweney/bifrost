require 'log4r'
require 'log4r/outputter/datefileoutputter'
include Log4r

# monkey-patch Log4r to prevent NoMethodError on startup in rails s.
class Log4r::Logger
  def formatter
  end
end

Rails.logger = Log4r::Logger.new('invint')
Rails.logger.level = Log4r::DEBUG

config_level = Log4r::INFO # TODO make configurable
if config_level.blank?
  config_level = Log4r::INFO
elsif config_level.is_a?(String)
  config_level = "Log4r::#{config_level}".constantize
end

# Set up outputters based on configuration.
format = PatternFormatter.new(:pattern => "[%d] [%l] %m")
stdout = Outputter.stdout
stdout.formatter = format
stdout.level = config_level
Rails.logger.outputters << stdout

outputter = Log4r::DateFileOutputter.new('outputter', {
  dirname: "#{Rails.root}/log",
  filename: "application.log",
  formatter: format,
  level: config_level
})
Rails.logger.outputters << outputter

