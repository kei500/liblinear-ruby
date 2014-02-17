$: << File.expand_path(File.join(__FILE__, '..', '..', 'lib'))
require 'liblinear'

describe Liblinear do
  include Liblinear
  include Liblinearswig

  before do
    @int_ruby_array = [1, 2, 3]
    @double_ruby_array = [1.0, 2.0, 3.0]
    @int_c_array = new_int_array(@int_ruby_array)
    @double_c_array = new_double_array(@double_ruby_array)
    @examples_hash = [{1=>1, 2=>2}, {3=>3, 4=>4}]
    @examples_array = [[1, 2], [3, 4, 5]]
    @example_hash = {1=>1, 2=>2, 3=>3}
    @example_array = [1, 2, 3]
  end

  describe 'solver type' do
    it 'solver type equal integer value defined Liblinearswig' do
      expect(Liblinear::L2R_LR).to eq(Liblinearswig::L2R_LR)
      expect(Liblinear::L2R_L2LOSS_SVC_DUAL).to eq(Liblinearswig::L2R_L2LOSS_SVC_DUAL)
      expect(Liblinear::L2R_L2LOSS_SVC).to eq(Liblinearswig::L2R_L2LOSS_SVC)
      expect(Liblinear::L2R_L1LOSS_SVC_DUAL).to eq(Liblinearswig::L2R_L1LOSS_SVC_DUAL)
      expect(Liblinear::MCSVM_CS).to eq(Liblinearswig::MCSVM_CS)
      expect(Liblinear::L1R_L2LOSS_SVC).to eq(Liblinearswig::L1R_L2LOSS_SVC)
      expect(Liblinear::L1R_LR).to eq(Liblinearswig::L1R_LR)
      expect(Liblinear::L2R_LR_DUAL).to eq(Liblinearswig::L2R_LR_DUAL)
      expect(Liblinear::L2R_L2LOSS_SVR).to eq(Liblinearswig::L2R_L2LOSS_SVR)
      expect(Liblinear::L2R_L2LOSS_SVR_DUAL).to eq(Liblinearswig::L2R_L2LOSS_SVR_DUAL)
      expect(Liblinear::L2R_L1LOSS_SVR_DUAL).to eq(Liblinearswig::L2R_L1LOSS_SVR_DUAL)
    end
  end

  describe '#new_int_array' do
    it 'returns [SWIG::TYPE_p_int]' do
      expect(new_int_array(@int_ruby_array).class).to eq(SWIG::TYPE_p_int)
    end
  end

  describe '#free_int_array' do
    it 'returns different array when free c array' do
      expect(int_array_c_to_ruby(@int_c_array, 3)).to eq(@int_ruby_array)
      free_int_array(@int_c_array)
      expect(int_array_c_to_ruby(@int_c_array, 3)).not_to eq(@int_ruby_array)
    end
  end

  describe '#new_double_array' do
    it 'returns [SWIG::TYPE_p_double]' do
      expect(new_double_array(@double_ruby_array).class).to eq(SWIG::TYPE_p_double)
    end
  end

  describe '#free_double_array' do
    it 'returns different array when free c array' do
      expect(double_array_c_to_ruby(@double_c_array, 3)).to eq(@double_ruby_array)
      free_double_array(@double_c_array)
      expect(double_array_c_to_ruby(@double_c_array, 3)).not_to eq(@double_ruby_array)
    end
  end

  describe '#int_array_c_to_ruby' do
    it 'returns [Array<Integer>]' do
      expect(int_array_c_to_ruby(@int_c_array, 3)).to eq(@int_ruby_array)
    end
  end

  describe '#double_array_c_to_ruby' do
    it 'returns [Array<Double>]' do
      expect(double_array_c_to_ruby(@double_c_array, 3)).to eq(@double_ruby_array)
    end
  end

  describe '#max_index' do
    it 'returns max key when example is [Hash]' do
      expect(max_index(@examples_hash)).to eq(4)
    end

    it 'returns max index + 1 when example is [Array]' do
      expect(max_index(@examples_array)).to eq(3)
    end
  end

  describe '#array_to_hash' do
    it 'returns hash whose key is index + 1 of array' do
      expect(array_to_hash(@example_array)).to eq(@example_hash)
    end

    it 'raise ArgumentError when array is not [Array]' do
      expect{array_to_hash(1)}.to raise_error(ArgumentError)
    end
  end

  describe '#convert_to_feature_node_array' do
    it 'returns [Liblinearswig::Feature_node] when example is [Hash]' do
      expect(convert_to_feature_node_array(@example_hash, 3).class).to eq(Liblinearswig::Feature_node)
    end

    it 'returns [Liblinearswig::Feature_node] when examples is [Array]' do
      expect(convert_to_feature_node_array(@example_array, 3).class).to eq(Liblinearswig::Feature_node)
    end
  end
end
