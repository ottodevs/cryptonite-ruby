# Check Bitcoin and Ethereum prices

    git clone git@github.com:davidhq/crypto-price-check.git
    cd crypto-price-check
    bundle
    ruby check.rb

![Screen](http://cl.ly/0O3m0r340s2p/Screen%20Shot%202016-01-17%20at%2003.28.16.png)

You can also set up something like

    cd ~/bin
    ~/bin$ ln -s ~/Projects/crypto-price-check/check.rb check

and then just

    check

from anywhere.

## More features

### Portfolio

    cp config.yml.sample config.yml

    nano config.yml
