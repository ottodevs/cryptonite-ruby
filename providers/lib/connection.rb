require 'faraday'
require 'faraday_middleware'
require_relative 'cache'
require_relative '../../util'

class Connection

  TIMEOUT = 5

  def self.create(api_base)
    @@cache ||= Cache.new
    @@cache_used = false
    Connection.new(api_base, @@cache) { |conn| }
  end

  def self.cache_used
    @@cache_used
  end

  def initialize(api_base, cache, &block)
    @api_base = api_base
    @cache = cache

    @conn = Faraday.new(api_base, &block)
    @conn.request :json
    @conn.response :json, :content_type => /\bjson$/
    @conn.adapter Connection.default_adapter
  end

  def self.default_adapter
    Faraday.default_adapter
  end

  def get(path, options = {})
    key = "#{@api_base}#{path} | #{options.inspect}"
    hit = @cache.get(key)

    log "GET #{key}"

    if result = Util.no_errors { Util.timeout(hit ? TIMEOUT : 2 * TIMEOUT) { @conn.get(path, options).body } }
      @cache.set(key, result)
      result
    elsif hit
      @@cache_used = true
      hit
    else
      raise "Error: No connection or cache for #{key}, sorry..."
    end
  end

end

class FakeConnection

  def initialize(api_base, &block)
  end

  def get(path)
    1
  end

end
