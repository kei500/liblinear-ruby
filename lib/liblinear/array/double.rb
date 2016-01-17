class Liblinear
  class Array::Double < Array
    class << self
      # @param array [SWIG::TYPE_p_double]
      # @param size [Integer]
      # @return [Array <Float>]
      def decode(array, size)
        size.times.map {|index| Liblinearswig.double_getitem(array, index)}
      end

      # @param array [SWIG::TYPE_p_double]
      def delete(array)
        Liblinearswig.delete_double(array)
      end
    end

    def initialize(array)
      @array = Liblinearswig.new_double(array.size)
      array.size.times do |index|
        Liblinearswig.double_setitem(@array, index, array[index])
      end
      @size = array.size
    end
  end
end
