# frozen_string_literal: true

require 'roda'
require 'r3d6-parser/lexer'
require 'r3d6-parser/parser'

class App < Roda
  opts[:parser] = R3D6::Parser::Parser.new
  opts[:lexer] = R3D6::Parser::Lexer.new

  plugin :default_headers,
         'Content-Type' => 'text/plain',
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
        ast = opts[:parser].parse(opts[:lexer].tokenize(roll))
        output = ast.evaluate request.params

        "#{ast.echo} = #{output}"
      rescue StandardError => e
        e.message
      end
    end
  end
end
