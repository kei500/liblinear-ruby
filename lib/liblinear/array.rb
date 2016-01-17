module Liblinear
  class Array
    def swig
      @array
    end

    def decode
      self.class.decode(@array, @size)
    end

    def delete
      self.class.delete(@array)
    end
  end
end
