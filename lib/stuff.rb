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
      counter += 1
      client = @tcp_server.accept
      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
      puts "Got this request:"
      puts request_lines.inspect
      puts "Sending response."
      response = @parser.final_response(request_lines)
      output   = find_output("Hello, World", hello_counter) && hello_counter += 1 if response == "Hello, World"
      output   = find_output("Total Requests:", counter)                          if response == "Total Requests:"
      output   = find_output(response)                                            if response == response
      client.puts header(output)
      client.puts output
      client.close
      @tcp_server.close if response == "Total Requests:"
    end
  end


  def header(output)
    ["http/1.1 200 ok",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end




    def find_output(type, arg)
      case type
      when "Hello, World"
        response = "Hello, World #{hello_counter}"
      when "Total Requests:"
        response = "Total Requests: #{counter}"
      else
        response
      end
      "<html><head></head><body><pre>#{response}</pre></body></html>"
    end

  end
  # hello_counter += 1                             if response == "Hello, World"


  #     if response == "Hello, World"
  #       hello_counter += 1
  #       output = output("hello", hello_counter)
  #       # output = "<html><head></head><body><pre>Hello, World #{hello_counter}</pre></body></html>"
  #       client.puts output
  #       client.close
  #     elsif response == "Total Requests:"
  #       output = output("total", counter)
  #       # output = "<html><head></head><body><pre>Total Requests: #{counter}</pre></body></html>"
  #       client.puts output
  #       client.close
  #       @tcp_server.close
  #     else
  #       output = output("other", response)
  #       output = "<html><head></head><body><pre>#{response}</pre></body></html>"
  #       client.puts output
  #       headers = ["http/1.1 200 ok",
  #         "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
  #         "server: ruby",
  #         "content-type: text/html; charset=iso-8859-1",
  #         "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  #       client.close
  #     end
  #   end
  # end
