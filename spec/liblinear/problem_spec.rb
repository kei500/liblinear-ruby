$: << File.expand_path(File.join(__FILE__, '..', '..', '..', 'lib'))
require 'liblinear'

describe Liblinear::Problem do
  include Liblinearswig
  before do
    @problem = Liblinear::Problem.new([1, 2], [[1],[2]])
  end

  describe '#initialize' do
    it 'raise ArgumentError when size of labels is different from that of examples' do
      expect{
        Liblinear::Problem.new([1, 2], [[1]])
      }.to raise_error(ArgumentError, 'labels and examples must be same size')
    end
  end

  describe '#prob' do
    it 'returns an instance of [Liblinearswig::Problem]' do
      expect(@problem.prob.class).to eq(Liblinearswig::Problem)
    end
  end
end
