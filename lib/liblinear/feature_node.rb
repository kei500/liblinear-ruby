module Liblinear
  class FeatureNode
    # @param examples [Array <Float> or Hash]
    # @param max_feature_id [Integer]
    # @param bias [Float]
    def initialize(example, max_feature_id, bias = -1)
      example = Liblinear::Example.array_to_hash(example) if example.is_a?(::Array)

      example_indexes = []
      example.each_key do |key|
        example_indexes << key
      end
      example_indexes.sort!

      if bias >= 0
        @feature_node = Liblinearswig.feature_node_array(example_indexes.size + 2)
        Liblinearswig.feature_node_array_set(@feature_node, example_indexes.size, max_feature_id + 1, bias)
        Liblinearswig.feature_node_array_set(@feature_node, example_indexes.size + 1, -1, 0)
      else
        @feature_node = Liblinearswig.feature_node_array(example_indexes.size + 1)
        Liblinearswig.feature_node_array_set(@feature_node, example_indexes.size, -1, 0)
      end

      f_index = 0
      example_indexes.each do |e_index|
        Liblinearswig.feature_node_array_set(@feature_node, f_index, e_index, example[e_index])
        f_index += 1
      end
    end

    # @return [Liblinearswig::Feature_node]
    def swig
      @feature_node
    end

    def delete
      Liblinearswig.feature_node_array_destroy(@feature_node)
    end
  end
end
