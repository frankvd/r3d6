# R3D6::Parser
Parses and evaluates dice roll expressions such as `4d6d1 + 4`

## Usage
```ruby
require 'r3d6-parser/lexer'
require 'r3d6-parser/parser'

lexer = R3D6::Parser::Lexer.new
parser = R3D6::Parser::Parser.new

tokens = lexer.tokenize "(4d6d1 - 3 + [STR]) * 3d3k1"
ast = parser.parse(tokens)
result = ast.evaluate({"STR" => 5})

puts "#{R3D6::Parser::Token.print(tokens)} = #{result}"
# ((4 + 4 + 2̵ + 3) - 3 + [5]) * (2̵ + 1̵ + 3) = 39
```

## Supported syntax
### Dice rolls
Dice rolls are specified using the number of dice and the number of sides per die separated by a `d` and are optionally followed by one or more modifiers. For example `4d6` indicates 4 dice each with 6 sides. 

#### Modifiers
There are two modifiers that can be applied to a dice roll: Drop lowest(`d`) and Keep highest(`k`).
For example `4d6d1` will roll 4 dice and drop the lowest result while `4d6k1` will roll 4 dice but only keep the highest result.

### Integers
Whole numbers can be used in expressions

### Operators
The `+`, `-`, `*` and `/` arithmetic operators are supported

### Variables
Variables can be referenced using by enclosing the name of the variable in square brackets. For example `[STR]` or `[MY_VARIABLE_NAME]`. Variables can only contain integer values. 

### Parentheses
Parentheses can be used to specify the order of operations
