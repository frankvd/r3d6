require 'parser/token'

module R3D6::Parser
    class Lexer
        def initialize
            @buffer = []
            @output = []
        end

        def tokenize(input)
            @output = []
            @buffer = []
            input.each_char do |c|
                next_char c
            end

            unless @buffer.empty?
                token = Token.new
                token.type = @buffer.include?('d') ? Token::Dice : Token::Number
                token.value = @buffer.join
                @output << token
            end

            @output
        end

        def next_char(c)
            case
            when is_digit(c)
                @buffer << c
            when c == 'd'
                @buffer << c unless @buffer.empty?
            when is_operator(c)
                unless @buffer.empty?
                    token = Token.new
                    token.type = @buffer.include?('d') ? Token::Dice : Token::Number
                    token.value = @buffer.join
                    @output << token
                    @buffer = []
                end

                token = Token.new
                token.type = Token::Operator
                token.value = c
                @output << token
            when is_whitespace(c) # Ignore whitespace
            else
                raise "Unexpected input"
            end
        end

        def is_digit(c)
            ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'].include? c
        end

        def is_operator(c)
            ['+', '-'].include? c
        end

        def is_whitespace(c)
            [" ", "\t"].include? c
        end
    end
end