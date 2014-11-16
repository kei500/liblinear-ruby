$: << File.expand_path(File.join(__FILE__, '..', '..', '..', 'lib'))
require 'liblinear'

describe Liblinear::CrossValidator do
  before do
    @prob = Liblinear::Problem.new([1, 2], [[1],[2]])
    @param_1 = Liblinear::Parameter.new
    @param_2 = Liblinear::Parameter.new({ solver_type: Liblinear::L2R_L2LOSS_SVR })

    @cv_classification = Liblinear::CrossValidator.new(@prob, @param_1, 2)
    @cv_classification.execute
    @cv_regression = Liblinear::CrossValidator.new(@prob, @param_2, 2)
    @cv_regression.execute
  end

  describe '#accuracy' do
    it 'returns accuracy' do
      expect(@cv_classification.accuracy.class).to eq(Float)
    end
  end

  describe '#mean_squared_error' do
    it 'returns mean_squared_error' do
      expect(@cv_regression.mean_squared_error.class).to eq(Float)
    end
  end

  describe 'squared_correlation_coefficient' do
    it 'returns squared_correlation_coefficient' do
      expect(@cv_regression.squared_correlation_coefficient.class).to eq(Float)
    end
  end
end
