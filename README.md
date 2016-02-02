## Setup

    git clone git@github.com:davidhq/crypto-portfolio.git
    cd crypto-portfolio
    bundle

## Check current prices.

    ruby check.rb

![Screen](http://cl.ly/0O3m0r340s2p/Screen%20Shot%202016-01-17%20at%2003.28.16.png)

## Add holdings

  Add amount of your holdings and see your crypto net worth.

    cp config.yml.sample config.yml

    nano config.yml

    ruby check.rb

## Specify currencies

Default is *usd*, but you can list *usd*, *eur*, *gbp* in config.yml
