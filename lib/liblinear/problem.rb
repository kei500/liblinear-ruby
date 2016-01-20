class Liblinear
  class Problem
    # @param labels [Array <Float>]
    # @param examples [Array <Array <Float> or Hash>]
    # @param bias [Float]
    def initialize(labels, examples, bias = -1)
      @labels   = labels
      @examples = examples
      @bias     = bias

      @problem = Liblinearswig::Problem.new
      @problem.y    = Liblinear::Array::Double.new(labels).swig
      @problem.x    = example_matrix.swig
      @problem.bias = bias
      @problem.l    = examples.size
      @problem.n    = Liblinear::Example.max_feature_id(examples)
      @problem.n += 1 if bias >= 0
    end

    # @return [Liblinearswig::Problem]
    def swig
      @problem
    end

    # @return [Integer]
    def example_size
      @problem.l
    end

    # @return [Integer]
    def max_feature_id
      @problem.n
    end

    # @return [Array <Float>]
    def labels
      Liblinear::Array::Double.decode(@problem.y, @labels.size)
    end

    # @return [Liblinear::FeatureNodeMatrix]
    def example_matrix
      Liblinear::FeatureNodeMatrix.new(@examples, @bias)
    end

    # @return [Float]
    def bias
      @problem.bias
    end
  end
end
