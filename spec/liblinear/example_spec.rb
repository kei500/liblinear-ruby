$: << File.expand_path(File.join(__FILE__, '..', '..', '..', 'lib'))
require 'liblinear'

describe Liblinear::Example do
  describe '#max_feature_id' do
    it 'returns max feature id' do
      expect(Liblinear::Example.max_feature_id([[1, 4], [1, 2, 3, 100]])).to eq(4)
      expect(Liblinear::Example.max_feature_id([{1 => 1, 2 => 2}, {100 => 100}])).to eq(100)
    end
  end

  describe '#array_to_hash' do
    it 'returns hash' do
      expect(Liblinear::Example.array_to_hash([1, 2, 3])).to eq({1 => 1, 2 => 2, 3 => 3})
    end
  end
end
