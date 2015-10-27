# Liblinear-Ruby
[![Gem Version](https://badge.fury.io/rb/liblinear-ruby.png)](http://badge.fury.io/rb/liblinear-ruby)

Liblinear-Ruby is Ruby interface to LIBLINEAR using SWIG.
Now, this interface is supporting LIBLINEAR 2.1.

## Installation

Add this line to your application's Gemfile:

    gem 'liblinear-ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install liblinear-ruby

## Quick Start
This sample code execute classification with L2-regularized logistic regression.
```ruby
require 'liblinear'

# Setting parameters
param = Liblinear::Parameter.new
param.solver_type = Liblinear::L2R_LR

# Training phase
labels = [1, -1]
examples = [
  {1=>0, 2=>0, 3=>0, 4=>0, 5=>0},
  {1=>1, 2=>1, 3=>1, 4=>1, 5=>1}
]
bias = 0.5
prob = Liblinear::Problem.new(labels, examples, bias)
model = Liblinear::Model.new(prob, param)

# Predicting phase
puts model.predict({1=>1, 2=>1, 3=>1, 4=>1, 5=>1}) # => -1.0

# Analyzing phase
puts model.coefficient
puts model.bias

# Cross Validation
fold = 2
cv = Liblinear::CrossValidator.new(prob, param, fold)
cv.execute

puts cv.accuracy                        # for classification
puts cv.mean_squared_error              # for regression
puts cv.squared_correlation_coefficient # for regression
```
## Usage

### Setting parameters
First, you have to make an instance of Liblinear::Parameter:
```ruby
param = Liblinear::Parameter.new
```
And then set the parameters as:
```ruby
param.[parameter_you_set] = value
```
Or you can set by Hash as:
```ruby
parameter = {
  parameter_you_set: value,
  ...
}
param = Liblinear::Parameter.new(parameter)
```

#### Type of solver
This parameter is comparable to -s option on command line.  
You can set as:
```ruby
param.solver_type = solver_type # default 1 (Liblinear::L2R_L2LOSS_SVC_DUAL)
```
Solver types you can set are shown below.
```ruby
# for multi-class classification
Liblinear::L2R_LR              # L2-regularized logistic regression (primal)
Liblinear::L2R_L2LOSS_SVC_DUAL # L2-regularized L2-loss support vector classification (dual)
Liblinear::L2R_L2LOSS_SVC      # L2-regularized L2-loss support vector classification (primal)
Liblinear::L2R_L1LOSS_SVC_DUAL # L2-regularized L1-loss support vector classification (dual)
Liblinear::MCSVM_CS            # support vector classification by Crammer and Singer
Liblinear::L1R_L2LOSS_SVC      # L1-regularized L2-loss support vector classification
Liblinear::L1R_LR              # L1-regularized logistic regression
Liblinear::L2R_LR_DUAL         # L2-regularized logistic regression (dual)

# for regression
Liblinear::L2R_L2LOSS_SVR      # L2-regularized L2-loss support vector regression (primal)
Liblinear::L2R_L2LOSS_SVR_DUAL # L2-regularized L2-loss support vector regression (dual)
Liblinear::L2R_L1LOSS_SVR_DUAL # L2-regularized L1-loss support vector regression (dual)
```

#### C parameter
This parameter is comparable to -c option on command line.   
You can set as:
```ruby
param.C = value # default 1
```

#### Epsilon in loss function of epsilon-SVR
This parameter is comparable to -p option on command line.   
You can set as:
```ruby
param.p = value # default 0.1
```

#### Tolerance of termination criterion
This parameter is comparable to -e option on command line.   
You can set as:
```ruby
param.eps = value # default 0.1
```

#### Weight
This parameter adjust the parameter C of different classes(see LIBLINEAR's README for details).  
nr_weight is the number of elements in the array weight_label and weight.  
You can set as:
```ruby
param.nr_weight = value                # default 0
param.weight_label = [Array <Integer>] # default []
param.weight = [Array <Double>]        # default []
```

### Training phase
You have to prepare training data.  
The format of training data is shown below:
```ruby
# Labels mean class
label = [1, -1, ...]

# Training data have to be array of hash or array of array
# If you chose array of hash
examples = [
  {1=>0, 2=>0, 3=>0, 4=>0, 5=>0},
  {1=>1, 2=>1, 3=>1, 4=>1, 5=>1},
  ...
]

# If you chose array of array
examples = [
  [0, 0, 0, 0, 0],
  [1, 1, 1, 1, 1],
]
```
Next, set the bias (this is comparable to -B option on command line):
```ruby
bias = 0.5 # default -1
```
And then make an instance of Liblinear::Problem and Liblinear::Model:
```ruby
prob = Liblinear::Problem.new(labels, examples, bias)
model = Liblinear::Model.new(prob, param)
```
If you have already had a model file, you can load it as:
```ruby
model = Liblinear::Model.new(model_file)
```
In this phase, you can save model as:
```ruby
model.save(file_name)
```

### Predicting phase
Input a data whose format is same as training data:
```ruby
# Hash
model.predict({1=>1, 2=>1, 3=>1, 4=>1, 5=>1})
# Array
model.predict([1, 1, 1, 1, 1])
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
