require_relative 'lib/provider'

class Bitstamp

  API_BASE = "https://www.bitstamp.net/api/"

  def btc_to_usd
    @price_usd ||= conn.get('ticker/')['last'].to_f
  end

  def btc_to_eur
    btc_to_usd / eur_to_usd
  end

  def eur_to_usd
    @ratio ||= conn.get('eur_usd/')['buy'].to_f
  end

private

  def conn
    Provider.connection(self, API_BASE)
  end

end
