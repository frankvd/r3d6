# frozen_string_literal: true

require 'r3d6-parser/lexer'
require 'r3d6-parser/parser'

include R3D6::Parser

RSpec.describe Node, '#echo' do
  it "describes the evaluation" do
    node = Nodes::BinaryExpression.new('+', Nodes::Integer.new(4), Nodes::Integer.new(5))
    node.evaluate
    expect(node.echo).to eq("4 + 5")
  end
end