module Liblinear
  class CrossValidator
    include Liblinear
    include Liblinearswig

    # @param prob [LibLinear::Problem]
    # @param param [Liblinear::Parameter]
    # @param fold [Integer]
    def initialize(prob, param, fold)
      @prob = prob
      @param = param
      @fold = fold
    end

    # @return [Array <Integer, Double>]
    def execute
      target = new_double_array(@prob.labels.size.times.map { 0.0 })
      cross_validation(@prob.prob, @param.param, @fold, target)
      @predictions = double_array_c_to_ruby(target, @prob.labels.size)
    end

    # @return [Double]
    def accuracy
      total_correct = 0
      @prob.labels.size.times do |i|
        total_correct += 1 if @predictions[i] == @prob.labels[i].to_f
      end
      total_correct.to_f / @prob.labels.size.to_f
    end

    # @return [Double]
    def mean_squared_error
      total_error = 0.0
      @prob.labels.size.times do |i|
        total_error += (@prob.labels[i].to_f - @predictions[i].to_f) ** 2
      end
      total_error / @prob.labels.size.to_f
    end

    # @return [Double]
    def squared_correlation_coefficient
      sum_x = 0.0
      sum_y = 0.0
      sum_xx = 0.0
      sum_yy = 0.0
      sum_xy = 0.0
      @prob.labels.size.times do |i|
        sum_x += @predictions[i].to_f
        sum_y += @prob.labels[i].to_f
        sum_xx += @predictions[i].to_f ** 2
        sum_yy += @prob.labels[i].to_f ** 2
        sum_xy += @predictions[i].to_f * @prob.labels[i].to_f
      end
      ((@prob.labels.size * sum_xy - sum_x * sum_y) ** 2) /
        ((@prob.labels.size * sum_xx - sum_x ** 2) * (@prob.labels.size * sum_yy - sum_y ** 2))
    end
  end
end
