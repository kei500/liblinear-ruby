$: << File.expand_path(File.join(__FILE__, '..', '..', '..', 'lib'))
require 'liblinear'

describe Liblinear::Problem do
  include Liblinearswig
  before do
    @problem = Liblinear::Problem.new([1, 2], [[1],[2]])
  end

  describe '#swig' do
    it 'returns [Liblinearswig::Problem]' do
      expect(@problem.swig.class).to eq(Liblinearswig::Problem)
    end
  end

  describe '#example_size' do
    it 'returns example size' do
      expect(@problem.example_size).to eq(2)
    end
  end

  describe '#max_feature_id' do
    it 'returns max feature id' do
      expect(@problem.max_feature_id).to eq(1)
    end
  end

  describe '#labels' do
    it 'returns labels' do
      expect(@problem.labels).to eq([1, 2])
    end
  end

  describe '#example_matrix' do
    it 'returns example matrix' do
      expect(@problem.example_matrix.class).to eq(Liblinear::FeatureNodeMatrix)
    end
  end

  describe '#bias' do
    it 'returns bias' do
      expect(@problem.bias).to eq(-1)
    end
  end
end
