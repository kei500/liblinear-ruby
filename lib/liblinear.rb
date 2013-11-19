$: << File.expand_path(File.join(__FILE__, '..', '..', 'ext'))

require 'liblinearswig'
require 'liblinear/error'
require 'liblinear/model'
require 'liblinear/parameter'
require 'liblinear/problem'
require 'liblinear/version'

module Liblinear
  # @param ruby_array [Array<Integer>]
  # @return [SWIG::TYPE_p_int]
  def new_int_array(ruby_array)
    c_int_array = Liblinearswig.new_int(ruby_array.size)
    ruby_array.size.times do |index|
      Liblinearswig.int_setitem(c_int_array, index, ruby_array[index])
    end
    c_int_array
  end

  # @param c_array [SWIG::TYPE_p_int]
  def free_int_array(c_array)
    delete_int(c_array) unless c_array.nil?
  end

  # @param ruby_array [Array<Double>]
  # @return [SWIG::TYPE_p_double]
  def new_double_array(ruby_array)
    c_double_array = Liblinearswig.new_double(ruby_array.size)
    ruby_array.size.times do |index|
      Liblinearswig.double_setitem(c_double_array, index, ruby_array[index])
    end
    c_double_array
  end

  # @param c_array [SWIG::TYPE_p_double]
  def free_double_array(c_array)
    delete_double(c_array) unless c_array.nil?
  end

  # @param c_array [SWIG::TYPE_p_int]
  # @param size [Integer]
  # @return [Array<Integer>]
  def int_array_c_to_ruby(c_array, size)
    size.times.map {|index| int_getitem(c_array, index)}
  end

  # @param c_array [SWIG::TYPE_p_double]
  # @param size [Integer]
  # @return [Array<Double>]
  def double_array_c_to_ruby(c_array, size)
    size.times.map {|index| double_getitem(c_array, index)}
  end

  # @param example [Hash, Array]
  # @param max_value_index [Integer]
  # @param bias [Double]
  # @return [Liblinearswig::Feature_node]
  def convert_to_feature_node_array(example, max_value_index, bias = -1)
    example_indexes = []
    if example.is_a?(Hash)
      example.each_key do |key|
        example_indexes << key
      end
    elsif example.is_a?(Array)
      example.each_index do |index|
        example_indexes << index
      end
    else
      raise TypeError, 'example must be a Hash or an Array'
    end
    example_indexes.sort!

    if bias >= 0
      feature_nodes = Liblinearswig.feature_node_array(example_indexes.size + 2)
      Liblinearswig.feature_node_array_set(feature_nodes, example_indexes.size, max_value_index + 1, bias)
      Liblinearswig.feature_node_array_set(feature_nodes, example_indexes.size + 1, -1, 0)
    else
      feature_nodes = Liblinearswig.feature_node_array(example_indexes.size + 1)
      Liblinearswig.feature_node_array_set(feature_nodes, example_indexes.size, -1, 0)
    end

    f_index = 0
    example_indexes.each do |e_index|
      Liblinearswig.feature_node_array_set(feature_nodes, f_index, e_index, example[e_index])
      f_index += 1
    end
    feature_nodes
  end
end
