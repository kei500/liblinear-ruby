module Liblinear
  class FeatureNodeMatrix
    # @param examples [Array <Array <Float> or Hash>]
    # @param bias [Float]
    def initialize(examples, bias)
      @feature_node_matrix = Liblinearswig.feature_node_matrix(examples.size)
      max_feature_id = Liblinear::Example.max_feature_id(examples)
      examples.size.times do |index|
        feature_node = Liblinear::FeatureNode.new(examples[index], max_feature_id, bias)
        Liblinearswig.feature_node_matrix_set(@feature_node_matrix, index, feature_node.swig)
      end
    end

    # @return [SWIG::TYPE_p_p_feature_node]
    def swig
      @feature_node_matrix
    end
  end
end
