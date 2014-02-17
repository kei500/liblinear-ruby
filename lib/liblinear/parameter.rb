module Liblinear
  class Parameter
    include Liblinear
    include Liblinearswig
    attr_accessor :params

    # @param params [Hash]
    def initialize(params = {})
      @params = Liblinearswig::Parameter.new
      self.solver_type = 1
      self.C = 1
      self.eps = 0.1
      self.p = 0.1
      self.nr_weight = 0
      self.weight_label = []
      self.weight = []
      params.each do |k, v|
        self.send("#{k}=", v)
      end
    end

    # @params weigt_label [Array <Integer>]
    def weight_label=(weight_label)
      free_int_array(@params.weight_label)
      @params.weight_label = new_int_array(weight_label)
    end

    # @params weight [Array <Double>]
    def weight=(weight)
      free_double_array(@params.weight)
      @params.weight = new_double_array(weight)
    end

    def method_missing(m, *args)
      if m.to_s.index('=')
        @params.send(m.to_sym, args.first)
      else
        @params.send(m.to_sym)
      end
    end
  end
end
