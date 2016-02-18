require 'colorize'
require 'timeout'

DEBUG = File.exists?(File.join(File.dirname(__FILE__), '.debug'))

def log(msg)
  msg = msg.is_a?(String) ? msg : msg.inspect
  puts msg.colorize(:yellow) if DEBUG
end

log "Debug mode"

class Util

  def self.silence_warnings(&block)
    warn_level = $VERBOSE
    $VERBOSE = nil
    result = block.call
    $VERBOSE = warn_level
    result
  end

  def self.symbolize_keys(hash)
    hash.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
  end

  def self.timeout(time, &block)
    Timeout::timeout(time) do
      block.call
    end
  rescue Timeout::Error
    false
  end

  def self.no_errors(&block)
    block.call
  rescue
    false
  end

end
