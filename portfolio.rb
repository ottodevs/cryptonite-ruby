require_relative 'config'

class Portfolio

  def show(prices, currency_converter)
    if config = Config.load['crypto']

      total = 0
      puts "\nTotal".green

      if btc = config['btc']
        sum_btc = btc['amount'].to_f * Currency.convert_usd(prices.price(Currency::BTC), currency_converter)
        total += sum_btc
      end

      if eth = config['eth']
        sum_eth = eth['amount'].to_f * Currency.convert_usd(prices.price(Currency::ETH), currency_converter)
        total += sum_eth
      end

      if krm = config['krm']
        sum_krm = krm['amount'].to_f * Currency.convert_usd(prices.price(Currency::KRM), currency_converter)
        total += sum_krm
      end

      if total > 0
        puts "BTC: #{Currency.format(sum_btc.round)} (#{(100.0 * sum_btc / total).round}%)" if btc
        puts "ETH: #{Currency.format(sum_eth.round)} (#{(100.0 * sum_eth / total).round}%)" if eth
        puts "KRM: #{Currency.format(sum_krm.round)} (#{(100.0 * sum_krm / total).round}%)" if krm
        puts "Sum: #{Currency.format(total.round)}".yellow
      end
    end
  end

end
