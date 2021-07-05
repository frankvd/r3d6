# frozen_string_literal: true

require 'r3d6-parser/lexer'
require 'r3d6-parser/parser'

include R3D6::Parser

RSpec.describe Nodes::Variable, '#evaluate' do
  it 'reads the value of the variable from the environment' do
    node = Nodes::Variable.new('DEX')

    expect(node.evaluate({ 'DEX' => 7 })).to eq(7)
  end

  it 'raises an error when a variable is not defined' do
    node = Nodes::Variable.new('WIS')

    expect { node.evaluate({ 'STR' => 1 }) }.to raise_error('Undefined variable [WIS]')
  end
end
