require_relative 'config'

class Portfolio

  def show(prices)
    if config = Config.load['crypto']

      def format_price(num)
        num.to_s.reverse.gsub(/...(?=.)/,'\&.').reverse
      end

      total = 0
      puts "\nTotal".green

      if btc = config['btc']
        sum_btc = btc['amount'].to_f * prices.convert_usd_eur(prices.btc_price)
        total += sum_btc
      end

      if eth = config['eth']
        sum_eth = eth['amount'].to_f * prices.convert_usd_eur(prices.eth_price)
        total += sum_eth
      end

      if total > 0
        puts "BTC: #{format_price(sum_btc.round)}€ (#{(100.0 * sum_btc / total).round}%)"
        puts "ETH: #{format_price(sum_eth.round)}€ (#{(100.0 * sum_eth / total).round}%)"
        puts "Sum: #{format_price(total.round)}€".yellow
      end

    end
  end

end
