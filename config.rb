require 'json'
require_relative 'util'

Util.silence_warnings { Object.send(:remove_const, :Config) if Object.const_defined?('Config') }

class Config

  def self.load
    config_file = File.join(File.dirname(__FILE__), 'config.json')
    @@config ||= File.exists?(config_file) ? JSON.parse(File.read(config_file)) : {}
  end

end
