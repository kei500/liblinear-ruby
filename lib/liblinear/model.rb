module Liblinear
  class Model
    include Liblinear
    include Liblinearswig
    attr_accessor :model

    # @param arg_1 [LibLinear::Problem, String]
    # @param arg_2 [Liblinear::Parameter]
    # @raise [ArgumentError]
    # @raise [Liblinear::InvalidParameter]
    def initialize(arg_1, arg_2 = nil)
      if arg_2
        unless arg_1.is_a?(Liblinear::Problem) && arg_2.is_a?(Liblinear::Parameter)
          raise ArgumentError, 'arguments must be [Liblinear::Problem] and [Liblinear::Parameter]'
        end
        error_msg = check_parameter(arg_1.prob, arg_2.params)
        raise InvalidParameter, error_msg if error_msg
        @model = train(arg_1.prob, arg_2.params)
      else
        raise ArgumentError, 'argument must be [String]' unless arg_1.is_a?(String)
        @model = load_model(arg_1)
      end
    end

    # @return [Integer]
    def nr_class
      get_nr_class(@model)
    end

    # @return [Integer]
    def feature_size
      get_nr_feature(@model)
    end

    # @return [Array <Integer>]
    def labels
      c_int_array = new_int(nr_class)
      get_labels(@model, c_int_array)
      labels = int_array_c_to_ruby(c_int_array, nr_class)
      delete_int(c_int_array)
      labels
    end

    # @param example [Array, Hash]
    # @return [Double]
    def predict(example)
      feature_nodes = convert_to_feature_node_array(example, @model.nr_feature, @model.bias)
      prediction = Liblinearswig.predict(@model, feature_nodes)
      feature_node_array_destroy(feature_nodes)
      prediction
    end

    # @param example [Array, Hash]
    # @return [Hash]
    def predict_probability(example)
      predict_prob_val(example, :predict_probability)
    end

    # @param example [Array, Hash]
    # @return [Hash]
    def predict_values(example)
      predict_prob_val(example, :predict_values)
    end

    # @param filename [String]
    def save(filename)
      save_model(filename, @model)
    end

    # @return [Boolean]
    def regression_model?
      check_regression_model(@model) == 1 ? true : false
    end

    private
    # @param example [Array, Hash]
    # @return [Hash]
    def predict_prob_val(example, liblinear_func)
      feature_nodes = convert_to_feature_node_array(example, @model.nr_feature, @model.bias)
      c_double_array = Liblinearswig.new_double(nr_class)
      Liblinearswig.send(liblinear_func, @model, feature_nodes, c_double_array)
      values = double_array_c_to_ruby(c_double_array, nr_class)
      delete_double(c_double_array)
      feature_node_array_destroy(feature_nodes)
      value_list = {}
      labels.size.times do |i|
        value_list[labels[i]] = values[i]
      end
      value_list
    end
  end
end
