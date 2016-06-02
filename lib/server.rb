require 'socket'
require './lib/router'
require './lib/parser'
require './lib/game'
require "pry"

class Server
  attr_reader       :tcp_server,
                    :router,
                    :parser,
                    :game

  def initialize
    @tcp_server     = TCPServer.new(9292)
    @game           = Game.new
    @router         = Router.new(game)
    @parser         = Parser.new(self)
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
      end #want to make method here to line 39
      verb = request_lines[0].split[0]
      path = request_lines[0].split[1]
      num = @parser.get_content_length(request_lines)
      read_client = client.read(num).split(" ")[4]
      if read_client != nil && game.game_start
        guess = read_client.to_i
        if router.determine_path(verb, path, guess) == "Valid POST for /game"
          game.record_guess(guess)
          binding.pry
        end
      end
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
