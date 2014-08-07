$: << File.expand_path(File.join(__FILE__, '..', '..', '..', 'lib'))
require 'liblinear'

describe Liblinear::Model do
  before do
    @prob = Liblinear::Problem.new([1, 2], [[1],[2]])
    @param = Liblinear::Parameter.new
    @model = Liblinear::Model.new(@prob, @param)
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

  describe '#nr_class' do
    it 'returns the number of classes' do
      expect(@model.nr_class).to eq(2)
    end
  end

  describe '#labels' do
    it 'returns labels' do
      expect(@model.labels).to eq([1, 2])
    end
  end

  describe '#predict' do
    it 'return predicted class' do
      expect(@model.predict([1]).class).to eq(Float)
    end
  end

  describe '#predict_probability' do
    it 'return predict_probability' do
      expect(@model.predict_probability([1]).class).to eq(Hash)
    end
  end

  describe '#predict_values' do
    it 'return predict_values' do
      expect(@model.predict_values([1]).class).to eq(Hash)
    end
  end
end
