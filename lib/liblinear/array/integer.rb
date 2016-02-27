class Liblinear
  class Array::Integer < Array
    class << self
      # @param array [SWIG::TYPE_p_int]
      # @param size [Integer]
      # @param return [Array <Integer>]
      def decode(array, size)
        size.times.map {|index| Liblinearswig.int_getitem(array, index)}
      end

      # @param array [SWIG::TYPE_p_int]
      def delete(array)
        Liblinearswig.delete_int(array)
      end
    end

    # @param array [Array <Integer>]
    def initialize(array)
      @array = Liblinearswig.new_int(array.size)
      array.size.times do |index|
        Liblinearswig.int_setitem(@array, index, array[index])
      end
      @size = array.size
    end
  end
end
