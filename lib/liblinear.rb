$: << File.expand_path(File.join(__FILE__, '..', '..', 'ext'))

require 'liblinearswig'
require 'liblinear/array'
require 'liblinear/array/integer'
require 'liblinear/array/double'
require 'liblinear/cross_validator'
require 'liblinear/example'
require 'liblinear/feature_node'
require 'liblinear/feature_node_matrix'
require 'liblinear/error'
require 'liblinear/model'
require 'liblinear/parameter'
require 'liblinear/problem'
require 'liblinear/version'

class Liblinear
  L2R_LR              = Liblinearswig::L2R_LR
  L2R_L2LOSS_SVC_DUAL = Liblinearswig::L2R_L2LOSS_SVC_DUAL
  L2R_L2LOSS_SVC      = Liblinearswig::L2R_L2LOSS_SVC
  L2R_L1LOSS_SVC_DUAL = Liblinearswig::L2R_L1LOSS_SVC_DUAL
  MCSVM_CS            = Liblinearswig::MCSVM_CS
  L1R_L2LOSS_SVC      = Liblinearswig::L1R_L2LOSS_SVC
  L1R_LR              = Liblinearswig::L1R_LR
  L2R_LR_DUAL         = Liblinearswig::L2R_LR_DUAL
  L2R_L2LOSS_SVR      = Liblinearswig::L2R_L2LOSS_SVR
  L2R_L2LOSS_SVR_DUAL = Liblinearswig::L2R_L2LOSS_SVR_DUAL
  L2R_L1LOSS_SVR_DUAL = Liblinearswig::L2R_L1LOSS_SVR_DUAL

  class << self
    # @param problem [Liblinear::Problem]
    # @param parameter [Liblinear::Parameter]
    # @return [String]
    def check_parameter(problem, parameter)
      Liblinearswig.check_parameter(problem.swig, parameter.swig)
    end

    # @param fold [Integer]
    # @param parameter [Liblinear::Parameter]
    # @param labels [Array <Integer>]
    # @examples [Array [Array <Float> or Hash]
    # @bias [<Float>]
    # @return [Liblinear::Model]
    def cross_validation(fold, parameter, labels, examples, bias = -1)
      parameter = Liblinear::Parameter.new(parameter)
      problem = Liblinear::Problem.new(labels, examples, bias)
      error_message = self.check_parameter(problem, parameter)
      raise Liblinear::InvalidParameter, error_message if error_message
      prediction_swig = Liblinearswig.new_double(labels.size)
      Liblinearswig.cross_validation(problem.swig, parameter.swig, fold, prediction_swig)
      prediction = Liblinear::Array::Double.decode(prediction_swig, labels.size)
      Liblinear::Array::Double.delete(prediction_swig)
      prediction
    end
  end

  # @param parameter [Liblinear::Parameter]
  # @param labels [Array <Integer>]
  # @examples [Array [Array <Float> or Hash]
  # @bias [<Float>]
  # @return [Liblinear::Model]
  def train(parameter, labels, examples, bias = -1)
    parameter = Liblinear::Parameter.new(parameter)
    problem = Liblinear::Problem.new(labels, examples, bias)
    error_message = self.class.check_parameter(problem, parameter)
    raise Liblinear::InvalidParameter, error_message if error_message
    @model = Liblinear::Model.train(problem, parameter)
  end

  # @param file_name [String]
  # @return [Liblinear::Model]
  def load_model(file_name)
    @model = Liblinear::Model.load(file_name)
  end

  # @param file_name [String]
  def save_model(file_name)
    @model.save(file_name)
  end

  # @examples [Array <Float> or Hash]
  # @return [Integer]
  def predict(example)
    feature_node = Liblinear::FeatureNode.new(example, @model.feature_size, @model.bias)
    prediction = Liblinearswig.predict(@model.swig, feature_node.swig)
    feature_node.delete
    prediction
  end

  # @examples [Array <Float> or Hash]
  # @return [Array <Float>]
  def predict_probabilities(example)
    feature_node = Liblinear::FeatureNode.new(example, @model.feature_size, @model.bias)
    probability_swig = Liblinearswig.new_double(@model.class_size)
    Liblinearswig.predict_probability(@model.swig, feature_node.swig, probability_swig)
    probability = Liblinear::Array::Double.decode(probability_swig, @model.class_size)
    Liblinear::Array::Double.delete(probability_swig)
    feature_node.delete
    probability
  end

  # @examples [Array <Float> or Hash]
  # @return [Array <Float>]
  def predict_values(example)
    feature_node = Liblinear::FeatureNode.new(example, @model.feature_size, @model.bias)
    values_swig = Liblinearswig.new_double(@model.class_size)
    Liblinearswig.predict_values(@model.swig, feature_node.swig, values_swig)
    values = Liblinear::Array::Double.decode(values_swig, @model.class_size)
    Liblinear::Array::Double.delete(values_swig)
    feature_node.delete
    values
  end

  # @param feature_id [Integer]
  # @param label_index [Integer]
  # @return [Float]
  def decision_function_coefficient(feature_id, label_index)
    Liblinearswig.get_decfun_coef(@model.swig, feature_id, label_index)
  end

  # @param label_index [Integer]
  # @return [Float]
  def decision_function_bias(label_index)
    Liblinearswig.get_decfun_bias(@model.swig, label_index)
  end

  # @return [Array <Integer>]
  def labels
    labels_swig = Liblinearswig.new_int(@model.class_size)
    Liblinearswig.get_labels(@model.swig, labels_swig)
    labels = Liblinear::Array::Integer.decode(labels_swig, @model.class_size)
    Liblinear::Array::Integer.delete(labels_swig)
    labels
  end
end
