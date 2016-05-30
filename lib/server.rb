require 'socket'
require './lib/parser'
require "pry"

class Server
attr_reader       :tcp_server, :counter
attr_accessor     :request_lines, :client

  def initialize
    @tcp_server    = TCPServer.new(9292) #---> possibly make this TCP.Server.new(9292).accept
  end

  def receive_request
    @client = tcp_server.accept
    @request_lines = []
    while line = client.gets and !line.chomp.empty?
      @request_lines << line.chomp
    end
    @request_lines
  end

  def respond_to_client
    puts "Got this request:"
    puts @request_lines.inspect
    puts "Sending response."
    response = "<pre>" + Parser.new(@request_lines).final_response + "</pre>"
      if response == "<pre>Hello, World</pre>"
        response = "<pre>Hello, World #{@counter}</pre>"
      end
        output = "<html><head></head><body>#{response}</body></html>"
    @client.puts output
  end

  def open_server
    @counter = 0
    loop do
      @counter += 1
      receive_request
      respond_to_client
      @client.close
    end
  end

end

server = Server.new
server.open_server


# parser = Parser.new(server.receive_request)
