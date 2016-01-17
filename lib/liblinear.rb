$: << File.expand_path(File.join(__FILE__, '..', '..', 'ext'))

require 'liblinearswig'
require 'liblinear/array'
require 'liblinear/array/integer'
require 'liblinear/array/double'
require 'liblinear/cross_validator'
require 'liblinear/example'
require 'liblinear/feature_node'
require 'liblinear/feature_node_matrix'
require 'liblinear/error'
require 'liblinear/model'
require 'liblinear/parameter'
require 'liblinear/problem'
require 'liblinear/version'

module Liblinear
  L2R_LR              = Liblinearswig::L2R_LR
  L2R_L2LOSS_SVC_DUAL = Liblinearswig::L2R_L2LOSS_SVC_DUAL
  L2R_L2LOSS_SVC      = Liblinearswig::L2R_L2LOSS_SVC
  L2R_L1LOSS_SVC_DUAL = Liblinearswig::L2R_L1LOSS_SVC_DUAL
  MCSVM_CS            = Liblinearswig::MCSVM_CS
  L1R_L2LOSS_SVC      = Liblinearswig::L1R_L2LOSS_SVC
  L1R_LR              = Liblinearswig::L1R_LR
  L2R_LR_DUAL         = Liblinearswig::L2R_LR_DUAL
  L2R_L2LOSS_SVR      = Liblinearswig::L2R_L2LOSS_SVR
  L2R_L2LOSS_SVR_DUAL = Liblinearswig::L2R_L2LOSS_SVR_DUAL
  L2R_L1LOSS_SVR_DUAL = Liblinearswig::L2R_L1LOSS_SVR_DUAL
end
