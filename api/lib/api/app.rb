require 'sinatra/base'

require 'parser/token'
require 'parser/lexer'
require 'parser/parser'

class App < Sinatra::Base

    configure do
        set :lexer, R3D6::Parser::Lexer.new
        set :parser, R3D6::Parser::Parser.new
    end

    get '/*' do |roll|
        begin
            ast = settings.parser.parse(settings.lexer.tokenize(roll))
            output = ast.evaluate

            "#{ast.echo} = #{output}"
        rescue => exception
            exception.message
        end
    end
end