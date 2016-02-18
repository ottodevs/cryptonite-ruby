require_relative 'config'
require_relative 'providers/coinbase'
require_relative 'providers/kraken'

class Currency

  BTC = :btc
  USD = :usd
  ETH = :eth
  EUR = :eur
  GBP = :gbp

  DEFAULT_EXCHANGES = {
    btc: Coinbase.new,
    eth: Kraken.new
  }

  def self.symbol(currency)
    { BTC => { append: 'Ƀ' },
      USD => { prepend: '$' },
      ETH => { append: 'eth' },
      EUR => { append: '€' },
      GBP => { append: '£' }
    }[currency]
  end

  def self.format(value, currency = default)
    if cur = self.symbol(currency)
      if cur[:prepend]
        "#{cur[:prepend]}#{format_price(value)}"
      else
        "#{format_price(value)}#{cur[:append]}"
      end
    else
      "#{format_price(value)} #{currency}"
    end
  end

  def self.list
    currencies = Config.load['currencies']
    currencies ? currencies.gsub(' ', '').downcase.split(',').map { |cur| cur.to_sym } : [USD]
  end

  def self.default
    list ? list[0] : USD
  end

private

  # 1000000.00 => 1,000,000.00
  def self.format_price(num)
    num = num.to_s
    decimals = nil
    num, decimals = num.split('.') if num.include?('.')
    num = num.reverse.gsub(/...(?=.)/,'\&,').reverse
    decimals ? "#{num}.#{decimals}" : num
  end

end
