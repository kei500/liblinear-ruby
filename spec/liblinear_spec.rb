$: << File.expand_path(File.join(__FILE__, '..', '..', 'lib'))
require 'liblinear'

describe Liblinear do
  describe 'solver type' do
    it 'solver type equal integer value defined Liblinearswig' do
      expect(Liblinear::L2R_LR).to              eq(Liblinearswig::L2R_LR)
      expect(Liblinear::L2R_L2LOSS_SVC_DUAL).to eq(Liblinearswig::L2R_L2LOSS_SVC_DUAL)
      expect(Liblinear::L2R_L2LOSS_SVC).to      eq(Liblinearswig::L2R_L2LOSS_SVC)
      expect(Liblinear::L2R_L1LOSS_SVC_DUAL).to eq(Liblinearswig::L2R_L1LOSS_SVC_DUAL)
      expect(Liblinear::MCSVM_CS).to            eq(Liblinearswig::MCSVM_CS)
      expect(Liblinear::L1R_L2LOSS_SVC).to      eq(Liblinearswig::L1R_L2LOSS_SVC)
      expect(Liblinear::L1R_LR).to              eq(Liblinearswig::L1R_LR)
      expect(Liblinear::L2R_LR_DUAL).to         eq(Liblinearswig::L2R_LR_DUAL)
      expect(Liblinear::L2R_L2LOSS_SVR).to      eq(Liblinearswig::L2R_L2LOSS_SVR)
      expect(Liblinear::L2R_L2LOSS_SVR_DUAL).to eq(Liblinearswig::L2R_L2LOSS_SVR_DUAL)
      expect(Liblinear::L2R_L1LOSS_SVR_DUAL).to eq(Liblinearswig::L2R_L1LOSS_SVR_DUAL)
    end
  end

  describe 'class method' do
    describe '#check_parameter' do
      it 'returns error message' do
        expect(
          Liblinear.check_parameter(
            Liblinear::Problem.new([1, 2], [[1], [2]]),
            Liblinear::Parameter.new({cost: -1})
          )
        ).to eq('C <= 0')
      end
    end

    describe '#cross_validation' do
      it 'returns cross validation result' do
        expect(
          Liblinear.cross_validation(
            2,
            {},
            [1, 2],
            [[1], [-1]]
          ).class
        ).to eq(Array)
      end
    end
  end

  describe 'instance method' do
    before do
      @liblinear = Liblinear.new
      @liblinear.train({}, [1, 2], [[1], [-1]])
    end

    describe '#predict' do
      it 'returns prediction' do
        expect(@liblinear.predict([1])).to eq(1)
      end
    end

    describe 'labels' do
      it 'returns labels' do
        expect(@liblinear.labels).to eq([1, 2])
      end
    end
  end
end
