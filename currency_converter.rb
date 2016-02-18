require_relative 'providers/bitstamp'
require_relative 'providers/coinbase'
require_relative 'providers/kraken'
require_relative 'providers/poloniex'
require_relative 'currency'
require_relative 'util'

class CurrencyConverter

  def initialize(basis)
    log "Initialized currency converter based on #{basis}"
    @basis = basis.to_sym
  end

  def ratio(from, to, crypto_exchanges)
    from = from.to_sym
    to = to.to_sym

    # it's a string when coming from config yaml
    exchanges = Util.symbolize_keys(crypto_exchanges)
    # create actual exchange providers from config strings
    exchanges.each { |crypto, exchange_str| exchanges[crypto] = Object::const_get(exchange_str.capitalize).new if exchange_str.is_a?(String) }

    if from == to
      1
    elsif conv = conversions(exchanges)[@basis][[from, to]]
      log "Converted #{from} to #{to} via #{conv[0].class}"
      conv[1].call
    elsif conv = conversions(exchanges)[@basis][[to, from]]
      log "Converted #{from} to #{to} via #{conv[0].class}"
      1 / conv[1].call
    elsif ![from, to].include?(Currency::ETH) and ratio = coinbase.convert(from, to)
      # Coinbase supports all conversions between Fiat and BTC, but no ETH
      log "Converted #{from} to #{to} via Coinbase"
      ratio
    else
      #log "Converting #{from}-#{@basis} AND #{@basis}-#{to}..."
      ratio(from, @basis, exchanges) * ratio(@basis, to, exchanges)
    end
  end

private

  # conversions are per basis,
  # has to provide all conversions either from- or -to basis
  def conversions(exchanges)
    @conversions ||= {
      Currency::USD => { # all conversions to or from USD
        [Currency::BTC, Currency::USD] => [exchanges[:btc], lambda { exchanges[:btc].btc_to_usd }],
        [Currency::ETH, Currency::USD] => [exchanges[:eth], lambda { exchanges[:eth].eth_to_usd }]
      },
      Currency::BTC => { # all conversions to or from BTC
        [Currency::BTC, Currency::USD] => [exchanges[:btc], lambda { exchanges[:btc].btc_to_usd }],
        [Currency::ETH, Currency::BTC] => [exchanges[:eth], lambda { exchanges[:eth].eth_to_btc }]
      }
    }
  end

  def coinbase
    @coinbase ||= Coinbase.new
  end

end
