$: << File.expand_path(File.join(__FILE__, '..', '..', '..', 'lib'))
require 'liblinear'

describe Liblinear::Parameter do
  before do
    @param = Liblinear::Parameter.new
  end

  describe '#solver_type' do
    it 'returns solver type' do
      @param.solver_type = 0
      expect(@param.solver_type).to eq(Liblinear::L2R_LR)
    end
  end

  describe '#c' do
    it 'returns C' do
      @param.C = 2
      expect(@param.C).to eq(2)
    end
  end

  describe '#eps' do
    it 'returns eps' do
      @param.eps = 0.0
      expect(@param.eps).to eq(0.0)
    end
  end

  describe '#p' do
    it 'returns p' do
      @param.p = 0.0
      expect(@param.p).to eq(0.0)
    end
  end

  describe '#nr_weight' do
    it 'returns nr_weight' do
      @param.nr_weight = 3
      expect(@param.nr_weight).to eq(3)
    end
  end

  describe '#weight_label' do
    it 'returns weight_label' do
      @param.weight_label = [1, 2, 3]
      expect(@param.weight_label.class).to eq(SWIG::TYPE_p_int)
    end
  end

  describe '#weight' do
    it 'returns weight' do
      @param.weight = [1.0, 2.0, 3.0]
      expect(@param.weight.class).to eq(SWIG::TYPE_p_double)
    end
  end
end
