require 'socket'
require './lib/parser'
require "pry"

# class Server
# attr_reader       :tcp_server, :counter
# attr_accessor     :request_lines, :client

  # def initialize
  #   @counter = 0
  #   @hello_counter = 0
  #   @tcp_server    = TCPServer.new(9292) #---> possibly make this TCP.Server.new(9292).accept
  # end
  #
  # def receive_request
  #   @client = tcp_server.accept
  #   @request_lines = []
  #   while line = client.gets and !line.chomp.empty?
  #     @request_lines << line.chomp
  #   end
  #   @request_lines
  # end
  #
  # def respond_to_client
  #   # puts @request_lines.inspect
  #   response = "<pre>" + Parser.new(@request_lines).final_response + "</pre>"
  #     if response == "<pre>Hello, World</pre>"
  #       @hello_counter += 1
  #       response = "<pre>Hello, World #{@hello_counter}</pre>"
  #     elsif response == "<pre>Total Requests:</pre>"
  #       response = "<pre>Total Requests: #{@counter}</pre>"
  #       @tcp_server.close
  #     end
  #       output = "<html><head></head><body>#{response}</body></html>"
  #   @client.puts output
  # end
  #
  # def open_server
  #   loop do
  #     @counter += 1
  #     receive_request
  #     respond_to_client
  #     @client.close
  #   end
  # end

  # def combined
    tcp_server    = TCPServer.new(9292) #---> possibly make this TCP.Server.new(9292).accept
    counter = 0
    hello_counter = 0
    loop do
      counter += 1
      client = tcp_server.accept
      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
      response = "<pre>" + Parser.new(request_lines).final_response + "</pre>"
      if response == "<pre>Hello, World</pre>"
        hello_counter += 1
        response = "<pre>Hello, World #{hello_counter}</pre>"
      elsif response == "<pre>Total Requests:</pre>"
        response = "<pre>Total Requests: #{counter}</pre>"
        tcp_server.close
      end
        output = "<html><head></head><body>#{response}</body></html>"
    client.puts output
    client.close
    end
  # end

# end

# server = Server.new
# server.combined


# parser = Parser.new(server.receive_request)
