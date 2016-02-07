require_relative 'connection'

class Kraken

  API_BASE = "https://api.kraken.com/0/public/"

  def price_usd
    @price_usd ||= prices['XETHZUSD']['a'][0].to_f
  end

  def price_eur
    @price_eur ||= prices['XETHZEUR']['a'][0].to_f
  end

private

  def prices
    @prices ||= conn.get('Ticker', pair: 'ETHEUR, ETHUSD, ETHGBP').body['result']
  end

  def conn
    @conn ||= Connection.new(API_BASE) do |conn|
      conn.request :json
      conn.response :json, :content_type => /\bjson$/
      conn.adapter Connection.default_adapter
    end
  end

end
