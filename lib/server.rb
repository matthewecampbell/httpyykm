require 'socket'
require './lib/parser'
require "pry"
class Server
attr_reader       :request_lines, :tcp_server

def initialize
  @tcp_server     = TCPServer.new(9292)
  @parser         = Parser.new
end

def start
  hello_counter   = 0
  counter         = 0
  loop do
    client = @tcp_server.accept
    request_lines = []
    while line = client.gets and !line.chomp.empty?
    request_lines << line.chomp
    end
    counter += 1
    response = @parser.final_response(request_lines)
    if response == "Hello, World"
      hello_counter += 1
      client.puts "<html><head></head><body><pre>Hello, World #{hello_counter}</pre></body></html>"
      client.close
    elsif response == "Total Requests:"
      client.puts "<html><head></head><body><pre>Total Requests: #{counter}</pre></body></html>"
      client.close
      @tcp_server.close
    else
      client.puts "<html><head></head><body><pre>#{response}</pre></body></html>"
      client.close
    end
  end
end
end

server = Server.new
server.start
