$: << File.expand_path(File.join(__FILE__, '..', '..', '..', 'lib'))
require 'liblinear'

describe Liblinear::Model do
  before do
    @prob = Liblinear::Problem.new([1, 2], [[1],[2]])
    @param_1 = Liblinear::Parameter.new
    @model_classification = Liblinear::Model.new(@prob, @param_1)

    @param_2 = Liblinear::Parameter.new({ solver_type: Liblinear::L2R_L2LOSS_SVR })
    @model_regression = Liblinear::Model.new(@prob, @param_2)
  end

  describe '#initialize' do
    it 'raise ArgumentError when arg_1 not equal [Liblinear::Problem] or arg_2 not equal [Liblinear::Parameter]' do
      expect{
        Liblinear::Model.new(1, 2)
      }.to raise_error(ArgumentError, 'arguments must be [Liblinear::Problem] and [Liblinear::Parameter]')
    end

    it 'raise Liblinear::InvalidParameter when parameter is invalid' do
      param = Liblinear::Parameter.new
      param.C = -1
      expect{
        Liblinear::Model.new(@prob, param)
      }.to raise_error(Liblinear::InvalidParameter, 'C <= 0')
    end

    it 'raise ArgumentError when argument is not [String]' do
      expect{
        Liblinear::Model.new(1)
      }.to raise_error(ArgumentError, 'argument must be [String]')
    end
  end

  describe '#class_size' do
    it 'returns the number of classes' do
      expect(@model_classification.class_size).to eq(2)
    end
  end

  describe '#feature_size' do
    it 'return the number of features' do
      expect(@model_classification.feature_size).to eq(1)
    end
  end

  describe '#labels' do
    it 'returns labels' do
      expect(@model_classification.labels).to eq([1, 2])
    end
  end

  describe '#predict' do
    it 'return predicted class' do
      expect(@model_classification.predict([1]).class).to eq(Float)
    end
  end

  describe '#predict_probability' do
    it 'return predict_probability' do
      expect(@model_classification.predict_probability([1]).class).to eq(Hash)
    end
  end

  describe '#predict_values' do
    it 'return predict_values' do
      expect(@model_classification.predict_values([1]).class).to eq(Hash)
    end
  end

  describe '#coefficient' do
    it 'returns a coefficient' do
      expect(@model_classification.coefficient(1, 0).class).to eq(Float)
    end

    it 'returns a coefficient' do
      expect(@model_classification.coefficient(1).class).to eq(Float)
    end

    it 'returns all coefficients' do
      expect(@model_classification.coefficient.class). to eq(Array)
    end
  end

  describe '#regression_model?' do
    it 'return true' do
      expect(@model_regression.regression_model?).to eq(true)
    end

    it 'return false' do
      expect(@model_classification.regression_model?).to eq (false)
    end
  end
end
