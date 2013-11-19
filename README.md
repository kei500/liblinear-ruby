# Liblinear-Ruby

Liblinear-Ruby is Ruby interface to LIBLINEAR(1.9.3) using SWIG.

## Installation

Add this line to your application's Gemfile:

    gem 'liblinear-ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install liblinear-ruby

## Usage

```ruby
require 'liblinear'
pa = Liblinear::Parameter.new({solver_type: 0})
bias = 0.5
labels = [1, 2]
# examples must be Array of Hash or Array
examples = [
  {1=>0, 2=>0, 3=>0, 4=>0, 5=>0},
  {1=>1, 2=>1, 3=>1, 4=>1, 5=>1}
]
pr = Liblinear::Problem.new(labels, examples, bias)
m = Liblinear::Model.new(pr, pa)
puts m.predict({1=>1, 2=>1, 3=>1, 4=>1, 5=>1}) # => 2.0
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Thanks
- http://www.csie.ntu.edu.tw/~cjlin/liblinear/
- https://github.com/tomz/liblinear-ruby-swig
