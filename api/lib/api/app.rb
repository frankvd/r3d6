# frozen_string_literal: true

require 'roda'
require 'r3d6-parser/lexer'
require 'r3d6-parser/parser'

class App < Roda
  opts[:parser] = R3D6::Parser::Parser.new
  opts[:lexer] = R3D6::Parser::Lexer.new

  plugin :default_headers,
         'Content-Type' => 'text/plain; charset=UTF-8',
         'Access-Control-Allow-Origin' => '*'

  route do |r|
    r.get 'favicon.ico' do
      response.status = 404
      ''
    end

    r.get String do |roll|
      roll = roll.gsub '+', '%2B'
      roll = CGI.unescape roll
      begin
        tokens = opts[:lexer].tokenize(roll)
        ast = opts[:parser].parse(tokens)
        output = ast.evaluate request.params

        "#{tokens.map(&:print).reject(&:empty?).join(' ')} = #{output}"
      rescue StandardError => e
        e.message
      end
    end
  end
end
