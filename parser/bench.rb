require "rubygems"
require "bundler/setup"
$LOAD_PATH.unshift File.dirname(__FILE__) + "/lib"
require "lexer"
require "parser"


test = '3d12+6'
start = Time.now
100000.times do 
    tokenizer = R3D6::Lexer.new test
    parser = R3D6::Parser.new
    tokens = tokenizer.tokenize
    # puts tokens.map(&:value).inspect
    ast = parser.parse tokens
    ast.evaluate
end

puts Time.now - start