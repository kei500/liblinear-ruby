$: << File.expand_path(File.join(__FILE__, '..', '..', '..', 'lib'))
require 'liblinear'

describe Liblinear::FeatureNodeMatrix do
  before do
    @feature_node_matrix = Liblinear::FeatureNodeMatrix.new([[1], [2]], -1)
  end

  describe '#swig' do
    it 'returns SWIG::TYPE_p_p_feature_node' do
      expect(@feature_node_matrix.swig.class).to eq(SWIG::TYPE_p_p_feature_node)
    end
  end
end
