module Liblinear
  class Parameter
    include Liblinear
    include Liblinearswig
    attr_accessor :param

    # @param param [Hash]
    def initialize(param = {})
      @param = Liblinearswig::Parameter.new
      self.solver_type = 1
      self.C = 1
      self.eps = 0.1
      self.p = 0.1
      self.nr_weight = 0
      self.weight_label = []
      self.weight = []
      param.each do |k, v|
        self.send("#{k}=", v)
      end
    end

    # @param weigt_label [Array <Integer>]
    def weight_label=(weight_label)
      free_int_array(@param.weight_label)
      @param.weight_label = new_int_array(weight_label)
    end

    # @param weight [Array <Double>]
    def weight=(weight)
      free_double_array(@param.weight)
      @param.weight = new_double_array(weight)
    end

    def method_missing(m, *args)
      if m.to_s.index('=')
        @param.send(m.to_sym, args.first)
      else
        @param.send(m.to_sym)
      end
    end
  end
end
