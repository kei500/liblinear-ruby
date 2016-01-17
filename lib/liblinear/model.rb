class Liblinear
  class Model
    class << self
      # @param problem [LibLinear::Problem]
      # @param parameter [Liblinear::Parameter]
      # @return [Liblinear::Model]
      def train(problem, parameter)
        model = self.new
        model.train(problem, parameter)
        model
      end

      # @param file_name [String]
      # @return [Liblinear::Model]
      def load(file_name)
        model = self.new
        model.load(file_name)
        model
      end
    end

    # @param problem [LibLinear::Problem]
    # @param parameter [Liblinear::Parameter]
    def train(problem, parameter)
      @model = Liblinearswig.train(problem.swig, parameter.swig)
    end

    # @param file_name [String]
    def load(file_name)
      @model = Liblinearswig.load_model(file_name)
    end

    # @return [Liblinear::Model]
    def swig
      @model
    end

    # @param filename [String]
    def save(filename)
      Liblinearswig.save_model(filename, @model)
    end

    # @return [Integer]
    def class_size
      @model.nr_class
    end

    # @return [Integer]
    def feature_size
      @model.nr_feature
    end

    # @return [Array <Float>]
    def feature_weights
      Liblinear::Array::Double.decode(@model.w, feature_size)
    end

    # @return [Float]
    def bias
      @model.bias
    end

    # @return [Array <Integer>]
    def labels
      Liblinear::Array::Integer.decode(@model.label, class_size)
    end

    # @return [Boolean]
    def probability_model?
      Liblinearswig.check_probability_model(@model) == 1 ? true : false
    end

    # @return [Boolean]
    def regression_model?
      Liblinearswig.check_regression_model(@model) == 1 ? true : false
    end
  end
end
