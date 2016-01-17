module Liblinear
  class Array::Integer < Array
    class << self
      def decode(array, size)
        size.times.map {|index| Liblinearswig.int_getitem(array, index)}
      end

      def delete(array)
        Liblinearswig.delete_int(array)
      end
    end

    def initialize(array)
      @array = Liblinearswig.new_int(array.size)
      array.size.times do |index|
        Liblinearswig.int_setitem(@array, index, array[index])
      end
      @size = array.size
    end
  end
end
