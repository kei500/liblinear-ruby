$: << File.expand_path(File.join(__FILE__, '..', '..', '..', '..', 'lib'))
require 'liblinear'

describe Liblinear::Array::Double do
  before do
    @array = Liblinear::Array::Double.new([1.0, 1.1, 1.2])
  end

  describe '#decode' do
    it 'returns decoded array' do
      expect(Liblinear::Array::Double.decode(@array.swig, 3)).to eq([1.0, 1.1, 1.2])
    end
  end

  describe '#delete' do
    it 'delete array' do
      Liblinear::Array::Double.delete(@array.swig)
      expect(Liblinear::Array::Double.decode(@array.swig, 3)).not_to eq([1.0, 1.1, 1.2])
    end
  end
end
