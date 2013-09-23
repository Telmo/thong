# Thong

_Because sometimes you don't want to cover it all_

Thong is a tongue in cheek reference to [coveralls](https://coveralls.io/). The purpose of thong is to provide similar capabilities to what [coveralls](https://coveralls.io/) provides for GitHub but being self hosted.

## Disclaimer

This is only the client side. It will currently report on the coverage for your code and if the .thong.yaml is present it will submit the report.

However until I don't finish the server side its just a nice "Coverage Report".

## TODO
 - Document the Code
 - Write RSpec .. aweful of me not to write those first :(

## Installation

Add this line to your application's Gemfile:

    gem 'thong'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install thong

## Usage

in your `spec_helper` add the following before requiring your application's code

```
require 'thong'
Thong.wear!
```
That's it

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
