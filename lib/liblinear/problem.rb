module Liblinear
  class Problem
    include Liblinear
    include Liblinearswig
    attr_accessor :prob

    # @param labels [Array <Double>]
    # @param examples [Array <Double, Hash>]
    # @param bias [Double]
    # @raise [ArgumentError]
    def initialize(labels, examples, bias = -1)
      unless labels.size == examples.size
        raise ArgumentError, 'labels and examples must be same size'
      end
      @prob = Liblinearswig::Problem.new
      @c_label = new_double_array(labels)
      @examples = examples
      @bias = bias
      @max_example_index = max_index(@examples)
      @example_matrix = feature_node_matrix(examples.size)
      @c_example_array = []

      set_example_matrix

      @prob.tap do |p|
        p.y = @c_label
        p.x = @example_matrix
        p.bias = bias
        p.l = examples.size
        p.n = @max_example_index
        p.n += 1 if bias >= 0
      end
    end

    def set_example_matrix
      @examples.size.times do |index|
        c_example = convert_to_feature_node_array(@examples[index], @max_example_index, @bias)
        @c_example_array << c_example
        feature_node_matrix_set(@example_matrix, index, c_example)
      end
    end
  end
end
