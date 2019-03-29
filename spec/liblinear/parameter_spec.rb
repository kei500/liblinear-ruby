$: << File.expand_path(File.join(__FILE__, '..', '..', '..', 'lib'))
require 'liblinear'

describe Liblinear::Parameter do
  describe 'class method' do
    describe '#default_epsilon' do
      it 'returns default value of epsilon' do
        expect(Liblinear::Parameter.default_epsilon(Liblinear::L2R_L2LOSS_SVR)).to eq(0.0001)
      end
    end
  end

  describe 'instance method' do
    before do
      @parameter = Liblinear::Parameter.new({
        solver_type:    Liblinear::L2R_LR,
        cost:           0.5,
        sensitive_loss: 0.2,
        epsilon:        0.5,
        weight_labels:  [1, 2],
        weights:        [0.1, 0.2],
      })
    end

    describe '#swig' do
      it 'returns [Liblinearswig::Parameter]' do
        expect(@parameter.swig.class).to eq(Liblinearswig::Parameter)
      end
    end

    describe '#solver_type' do
      it 'returns solver type' do
        expect(@parameter.solver_type).to eq(Liblinear::L2R_LR)
      end
    end

    describe '#cost' do
      it 'returns cost' do
        expect(@parameter.cost).to eq(0.5)
      end
    end

    describe '#sensitive_loss' do
      it 'returns sensitive loss' do
        expect(@parameter.sensitive_loss).to eq(0.2)
      end
    end

    describe '#epsilon' do
      it 'returns epsilon' do
        expect(@parameter.epsilon).to eq(0.5)
      end
    end

    describe '#weight_labels' do
      it 'returns weight labels' do
        expect(@parameter.weight_labels).to eq([1, 2])
      end
    end

    describe '#weights' do
      it 'returns weights' do
        expect(@parameter.weights).to eq([0.1, 0.2])
      end
    end
  end
end
