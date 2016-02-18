## Features

  - convert between any two fiat currencies
  - convert between bitcoin, ether and any fiat currency
  - check total crypto net worth (portfolio)
  - works offline with most recent data in case of no connection

## Setup

    git clone git@github.com:davidhq/cryptonite-ruby.git
    cd cryptonite-ruby
    bundle

## Check current value of Bitcoin and Ether

    ruby check.rb

## Add crypto portfolio holdings

    cp config.json.sample config.json

    nano config.json

  and see your crypto net worth:

    ruby check.rb

Crypto prices will be shown in all fiat currencies listed in `currencies` section of `config.json`, ex.: `usd, eur, hrk, gbp` and the
first one is used to show the aggregate portfolio value.

## Currency converter

Can convert **any fiat currency** plus `btc` and `eth`.

    ruby convert.rb "100 usd in btc"

    ruby convert.rb "300 eur in eth"

    ruby convert.rb "500 cny in eur"

## Debugging

    touch .debug
