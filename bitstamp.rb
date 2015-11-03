require 'faraday'
require 'faraday_middleware'

class Bitstamp

  API_BASE = "https://www.bitstamp.net/api/"

  def price_usd
    @price_usd ||= conn.get('ticker/').body['last'].to_f
  end

  def eur_usd
    @eur_usd ||= conn.get('eur_usd/').body['buy'].to_f
  end

  def price_eur
    @price_eur ||= '%.2f' % (price_usd / eur_usd)
  end

private

  def conn
    @conn ||= Faraday.new(API_BASE) do |conn|
      conn.request :json
      conn.response :json, :content_type => /\bjson$/
      conn.adapter Faraday.default_adapter
    end
  end

end