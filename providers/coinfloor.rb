require_relative 'connection'

class Coinfloor

  API_BASE = "https://webapi.coinfloor.co.uk:8090/bist/"

  def gbp_to_usd
    price_usd / price_gbp
  end

private

  def price_usd
    @price_usd ||= conn.get('XBT/USD/ticker/').body['last'].to_f
  end

  def price_gbp
    @price_gbp ||= conn.get('XBT/GBP/ticker/').body['last'].to_f
  end

  def conn
    @conn ||= Connection.new(API_BASE) do |conn|
      conn.request :json
      conn.response :json, :content_type => /\bjson$/
      conn.adapter Connection.default_adapter
    end
  end

end
