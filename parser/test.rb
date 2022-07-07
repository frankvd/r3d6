# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/lib"
require 'r3d6-parser/lexer'
require 'r3d6-parser/parser'

require 'pp'

test = '(3 d 6 d1+4)*2'

tokenizer = R3D6::Parser::Lexer.new

tokens = tokenizer.tokenize test

puts tokens.map(&:value).inspect

parser = R3D6::Parser::Parser.new
ast = parser.parse tokens

def print_node(node)
  puts node.value
  print_node(node.left) unless node.left.nil?
  print_node(node.right) unless node.right.nil?
end

print_node ast

out = ast.evaluate
puts "#{ast.echo} = #{out}"
