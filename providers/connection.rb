require 'faraday'
require 'faraday_middleware'

class Connection

  def initialize(api_base, &block)
    @api_base = api_base
    @conn ||= Faraday.new(api_base, &block)
  end

  def self.default_adapter
    Faraday.default_adapter
  end

  def get(path, options = {})
    @conn.get(path, options)
  end

end

# Identity
class FakeConnection

  def initialize(api_base, &block)
  end

  def get(path)
    10
  end

end
