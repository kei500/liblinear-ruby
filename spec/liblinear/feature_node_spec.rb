$: << File.expand_path(File.join(__FILE__, '..', '..', '..', 'lib'))
require 'liblinear'

describe Liblinear::FeatureNode do
  before do
    @feature_node = Liblinear::FeatureNode.new([1, 2], 2)
  end

  describe '#swig' do
    it 'returns Liblinearswig::Feature_node' do
      expect(@feature_node.swig.class).to eq(Liblinearswig::Feature_node)
    end
  end
end
