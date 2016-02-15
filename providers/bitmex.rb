require_relative 'lib/provider'

class Bitmex

  API_BASE = "https://www.bitmex.com/api/v1/"

  def mark_price
    @mark_price ||= conn.get('instrument/indices')[0]['markPrice']
  end

  def bid_price
    '%.2f' % bid_ask['bidPrice'].to_f
  end

  def ask_price
    '%.2f' % bid_ask['askPrice'].to_f
  end

private

  def bid_ask
    @bid_ask ||= conn.get('orderBook', { symbol: 'XBT24H', depth: 1 })[0]
  end

  def conn
    Provider.connection(self, API_BASE)
  end

end
