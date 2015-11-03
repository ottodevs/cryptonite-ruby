require 'faraday'
require 'faraday_middleware'

class Kraken

  API_BASE = "https://api.kraken.com/0/public/"

  def price_eur
    @price_eur ||= '%.2f' % prices['XETHZEUR']['a'][0].to_f
  end

  def price_usd
    @price_usd ||= '%.2f' % prices['XETHZUSD']['a'][0].to_f
  end

private

  def prices
    @prices ||= conn.get('Ticker', pair: 'ETHEUR, ETHUSD').body['result']
  end

  def conn
    @conn ||= Faraday.new(API_BASE) do |conn|
      conn.request :json
      conn.response :json, :content_type => /\bjson$/
      conn.adapter Faraday.default_adapter
    end
  end

end
