require_relative 'lib/connection'

class Poloniex

  API_BASE = "https://poloniex.com/public"

  def eth_to_btc
    prices['bids'][0][0].to_f
  end

private

  def prices
    @prices_btc_eth ||= conn.get('?command=returnOrderBook', currencyPair: 'BTC_ETH') #reverse terminology
  end

  def conn
    @conn ||= Connection.create(API_BASE)
  end

end
