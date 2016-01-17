module Liblinear
  class Example
    class << self
      # @param examples [Array <Hash, Array>]
      # @return [Integer]
      def max_feature_id(examples)
        max_feature_id = 0
        examples.each do |example|
          if example.is_a?(Hash)
            max_feature_id = [max_feature_id, example.keys.max].max if example.size > 0
          else
            max_feature_id = [max_feature_id, example.size].max
          end
        end
        max_feature_id
      end

      # @param example_array [Array]
      # @return [Hash]
      def array_to_hash(example_array)
        example_hash = {}
        example_array.size.times do |index|
          example_hash[index + 1] = example_array[index]
        end
        example_hash
      end
    end
  end
end
