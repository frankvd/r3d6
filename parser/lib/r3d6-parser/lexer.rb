require 'r3d6-parser/token'

module R3D6::Parser
    class Lexer
        def initialize
            @output = []
            @current = nil
        end

        def tokenize(input)
            @output = []
            @current = Token.new
            input.each_char do |c|
                next_char c
            end
            append unless @current.type == Token::Unknown

            @output
        end

        def next_char(c)
            case
            when is_digit(c)
                @current.value << c
                @current.type = Token::Number if @current.type == Token::Unknown
            when c == 'd'
                if [Token::Dice, Token::DiceRollModifier].include? @current.type
                    append
                    @current.type = Token::DiceRollModifier
                    @current.value << c
                elsif [Token::Number, Token::Unknown].include? @current.type
                    @current.value << c
                    @current.type = Token::Dice
                end
            when is_operator(c)
                append unless @current.type == Token::Unknown
                token = Token.new
                token.type = Token::Operator
                token.value = c
                @output << token
            when is_whitespace(c) # Ignore whitespace
            else
                raise "Unexpected input"
            end
        end

        def append
            @output << @current
            @current = Token.new
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