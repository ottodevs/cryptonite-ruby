require_relative 'connection'

class Krompir

  API_BASE = "https://bitcells.com/api"

  def price_usd
    1
  end

  def convert_usd_krm(usd)
    usd
  end

private

  def conn
    @conn ||= FakeConnection.new(API_BASE) do |conn|
    end
  end

end
