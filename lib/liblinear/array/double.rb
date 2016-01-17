module Liblinear
  class Array::Double < Array
    class << self
      def decode(array, size)
        size.times.map {|index| Liblinearswig.double_getitem(array, index)}
      end

      def delete(array)
        Liblinearswig.delete_double(array)
      end
    end

    def initialize(array)
      @array = Liblinearswig.new_double(array.size)
      array.size.times do |index|
        Liblinearswig.double_setitem(array, index, array[index])
      end
      @size = array.size
    end
  end
end
