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
      client.read(2).to_i
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
      num = @parser.get_content_length(request_lines)
      puts client.read(num)
      binding.pry
      puts "Got this request:"
      puts request_lines.inspect
      puts "Sending response."
      response = @parser.final_response(request_lines)
      if response == "Hello, World"
        hello_counter += 1
        output = find_output("Hello, World", hello_counter)
      elsif response == "Total Requests:"
        output  = find_output("Total Requests:", counter)
      else
        output  = find_output(response, nil)
      end
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
      response = "Hello, World #{arg}"
    when "Total Requests:"
      response = "Total Requests: #{arg}"
    else
      response = type
    end
      "<html><head></head><body><pre>#{response}</pre></body></html>"
    end
  end
