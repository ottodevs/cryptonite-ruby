require_relative 'lib/provider'

class Coinbase

  API_BASE = "https://api.coinbase.com/v2/"

  def btc_to_usd
    @price_usd ||= conn.get('prices/buy/')['data']['amount']
  end

  # converts Fiat / BTC to all other fiat currencies (or BTC) like CNY, AUD, BGN
  def convert(from, to)
    @cache ||= {}
    @cache[from] ||= conn.get('exchange-rates', currency: from.to_s.upcase)['data']
    if @cache[from] and rate = @cache[from]['rates'].find { |rate| rate[0].upcase == to.to_s.upcase }
      rate[1].to_f
    end
  end

private

  def conn
    Provider.connection(self, API_BASE)
  end

end
