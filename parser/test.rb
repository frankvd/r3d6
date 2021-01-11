require "rubygems"
require "bundler/setup"
$LOAD_PATH.unshift File.dirname(__FILE__) + "/lib"
require "parser/lexer"
require "parser/parser"

require 'pp'

test = '1+1+4d12'

characters = test.chars

tokenizer = R3D6::Parser::Lexer.new

tokens = tokenizer.tokenize test

puts tokens.map(&:value).inspect

parser = R3D6::Parser::Parser.new
ast = parser.parse tokens

def print_node(n)
    puts n.value
    print_node(n.left) unless n.left.nil?
    print_node(n.right) unless n.right.nil?
end


out = ast.evaluate
puts "#{ast.echo} = #{out}"