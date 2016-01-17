class Liblinear
  class Parameter
    class << self
      # @return [Float]
      def default_epsilon(solver_type)
        case solver_type
        when Liblinear::L2R_LR              then
          0.01
        when Liblinear::L2R_L2LOSS_SVC_DUAL then
          0.1
        when Liblinear::L2R_L2LOSS_SVC      then
          0.01
        when Liblinear::L2R_L1LOSS_SVC_DUAL then
          0.1
        when Liblinear::MCSVM_CS            then
          0.1
        when Liblinear::L1R_L2LOSS_SVC      then
          0.01
        when Liblinear::L1R_LR              then
          0.01
        when Liblinear::L2R_LR_DUAL         then
          0.1
        when Liblinear::L2R_L2LOSS_SVR      then
          0.001
        when Liblinear::L2R_L2LOSS_SVR_DUAL then
          0.1
        when Liblinear::L2R_L1LOSS_SVR_DUAL then
          0.1
        end
      end
    end

    # @param parameter [Hash]
    def initialize(parameter)
      parameter[:weight_labels] = [] if parameter[:weight_labels].nil?
      parameter[:weights]       = [] if parameter[:weights].nil?

      @parameter = Liblinearswig::Parameter.new
      @parameter.solver_type  = parameter[:solver_type] || Liblinear::L2R_L2LOSS_SVC_DUAL
      @parameter.C            = parameter[:cost] || 1.0
      @parameter.p            = parameter[:sensitive_loss] || 0.1
      @parameter.eps          = parameter[:epsilon] || self.class.default_epsilon(@parameter.solver_type)
      @parameter.nr_weight    = parameter[:weight_labels].size
      @parameter.weight_label = Liblinear::Array::Integer.new(parameter[:weight_labels]).swig
      @parameter.weight       = Liblinear::Array::Double.new(parameter[:weights]).swig
    end

    # @return [Liblinearswig::Parameter]
    def swig
      @parameter
    end

    # @return [Integer]
    def solver_type
      @parameter.solver_type
    end

    # @return [Float]
    def cost
      @parameter.C
    end

    # @return [Float]
    def sensitive_loss
      @parameter.p
    end

    # @return [Float]
    def epsilon
      @parameter.eps
    end

    # @return [Array <Integer>]
    def weight_labels
      Liblinear::Array::Integer.decode(@parameter.weight_label, @parameter.nr_weight)
    end

    # @return [Array <Float>]
    def weights
      Liblinear::Array::Double.decode(@parameter.weight, @parameter.nr_weight)
    end
  end
end
