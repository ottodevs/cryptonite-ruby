require_relative 'cache'
require_relative 'connection'

class Provider

  def self.connection(klass, api_base = nil)
    @@cache ||= Cache.new
    @@connections ||= {}
    api_base ? @@connections[klass] = Connection.new(api_base, @@cache) { |conn| } : @@connections[klass]
  end

  def self.used_cache
    @@cache.has_been_used
  end

end
