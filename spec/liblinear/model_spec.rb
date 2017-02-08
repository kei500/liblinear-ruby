$: << File.expand_path(File.join(__FILE__, '..', '..', '..', 'lib'))
require 'liblinear'

describe Liblinear::Model do
  before do
    Liblinear.quiet_mode
    @problem = Liblinear::Problem.new([1, 2], [[1],[2]])
    @parameter = Liblinear::Parameter.new()
    @model = Liblinear::Model.train(@problem, @parameter)
  end

  describe '#swig' do
    it 'returns [Liblinearswig::Model]' do
      expect(@model.swig.class).to eq(Liblinearswig::Model)
    end
  end

  describe '#class_size' do
    it 'returns class size' do
      expect(@model.class_size).to eq(2)
    end
  end

  describe '#feature_size' do
    it 'returns feature size' do
      expect(@model.feature_size).to eq(1)
    end
  end

  describe '#feature_weights' do
    it 'returns feature weights' do
      expect(@model.feature_weights.first.class).to eq(Float)
    end
  end

  describe '#bias' do
    it 'returns bias' do
      expect(@model.bias).to eq(-1)
    end
  end

  describe '#labels' do
    it 'returns labels' do
      expect(@model.labels).to eq([1, 2])
    end
  end

  describe '#probability_model?' do
    it 'returns false' do
      expect(@model.probability_model?).to eq(false)
    end
  end

  describe '#regression_model?' do
    it 'returns false' do
      expect(@model.regression_model?).to eq(false)
    end
  end
end
