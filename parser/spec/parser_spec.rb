require 'parser/lexer'
require 'parser/parser'

RSpec.describe R3D6::Parser::Parser, "#parse" do
    context "3d12 + 4" do
        it "Sums the output" do
            srand(42)
            test = '3d12+4'
            tokenizer = R3D6::Parser::Lexer.new
            tokens = tokenizer.tokenize(test)
            parser = R3D6::Parser::Parser.new
            ast = parser.parse tokens
            out = ast.evaluate

            expect(out).to eq(7 + 4 + 11 + 4)
        end
    end
end
